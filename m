From: thommyj@gmail.com (Thommy Jakobsson)
Date: Fri,  3 Jun 2016 14:19:13 +0200
Subject: [PATCH v2 0/2] arm-smmu: add master mask
In-Reply-To: <DB5PR0401MB186309ACEF30FEA489C3CA97E6580@DB5PR0401MB1863.eurprd04.prod.outlook.com>
References: <DB5PR0401MB186309ACEF30FEA489C3CA97E6580@DB5PR0401MB1863.eurprd04.prod.outlook.com>
Message-ID: <1464956355-2826-1-git-send-email-thommyj@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset makes it possible to manually set a mask for a master.
Default behaviour when not specifying a mask is to keep current behaviour.
If masks are specified for a master, all of its stream IDs needs to have a
mask.

Platforms with a large number of IDs per master starts to show up. Its
impractical to specify all available IDs in some cases. Specific example
is the ZynqMPSoC, where the streamid have 6 bits from the AXI ID. So 2^6
IDs for each PL port, which there are 6 of.

Thommy Jakobsson (2):
  arm-smmu: doc: add binding for stream ID mask
  arm-smmu: Add possibillity to mask streamIDs

 .../devicetree/bindings/iommu/arm,smmu.txt         | 15 ++++++-
 drivers/iommu/arm-smmu.c                           | 52 +++++++++++++++++++++-
 2 files changed, 63 insertions(+), 4 deletions(-)

--

version 2
 - fix bug of mask not beeing setup properly
 - changed to using of_for_each_phandle for DT mask parse
1.9.1
