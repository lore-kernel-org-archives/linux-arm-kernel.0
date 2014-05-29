From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 29 May 2014 10:03:54 -0500
Subject: [PATCH v2 03/18] PCI: designware: Configuration space should be
 specified in 'reg'
In-Reply-To: <1401345500-20188-4-git-send-email-kishon@ti.com>
References: <1401345500-20188-1-git-send-email-kishon@ti.com>
 <1401345500-20188-4-git-send-email-kishon@ti.com>
Message-ID: <98E18225-3C63-4106-901A-A5D3DEC268C8@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On May 29, 2014, at 1:38 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:

> The configuration address space has so far been specified in *ranges*,
> however it should be specified in *reg* making it a platform MEM resource.
> Hence used 'platform_get_resource_*' API to get configuration address
> space in the designware driver.
> 
> Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Mohit Kumar <mohit.kumar@st.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> .../devicetree/bindings/pci/designware-pcie.txt    |    1 +
> drivers/pci/host/pcie-designware.c                 |   17 +++++++++++++++--
> 2 files changed, 16 insertions(+), 2 deletions(-)

Why should the cfg space be defined in *reg* instead of ranges?

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
