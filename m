From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 27 Jan 2016 16:08:18 +0100
Subject: [PATCH 0/2] ARM: mvebu: network interface naming
Message-ID: <1453907300-28283-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear mvebu maintainers,

As was discussed back in November last year, the naming of network
interfaces on Armada 38x is very confusing. Gregory Clement suggested
to exceptionally violate the rule of "DT nodes should be ordered by
register address" in order to reduce the confusion.

The first patch implements this proposal.

The second patch is a new iteration of the patch that adds comments to
the Armada 385 DB AP Device Tree file. The contents of the patch is
the same (add indications of which physical connector corresponds each
port), only the commit log is adjusted to take into account the fact
that thanks to the first patch, the naming of the network interfaces
visible from Linux is now a lot more sane.

Thanks!

Thomas

Thomas Petazzoni (2):
  ARM: mvebu: change order of ethernet DT nodes on Armada 38x
  ARM: mvebu: add reference to ETH connectors for A385-AP

 arch/arm/boot/dts/armada-385-db-ap.dts |  3 +++
 arch/arm/boot/dts/armada-38x.dtsi      | 30 +++++++++++++++++++++---------
 2 files changed, 24 insertions(+), 9 deletions(-)

-- 
2.6.4
