From: s-anna@ti.com (Suman Anna)
Date: Mon, 11 Jan 2016 11:12:35 -0600
Subject: [PATCH 0/3] dra7xx: get pcie working in mainline
In-Reply-To: <1452440488-28398-1-git-send-email-kishon@ti.com>
References: <1452440488-28398-1-git-send-email-kishon@ti.com>
Message-ID: <5693E283.3090000@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

On 01/10/2016 09:41 AM, Kishon Vijay Abraham I wrote:
> This series adds pdata-quirk mechanism to reset PCIe as a temporary
> fix till reset controller driver is added in mainline.
> 
> Without this series, a stall is observed if pci dra7xx driver
> is enabled.
> 
> Kishon Vijay Abraham I (3):
>   ARM: DRA7: hwmod: Add reset data for PCIe
>   HACK: ARM: DRA7: add pdata-quirks to do reset of PCIe
>   HACK: pci: dra7xx: use pdata callbacks to perform reset

Please drop the HACK: tag from the commit headers, that was an internal
convention/choice made by Sekhar, and we had our differences there as it
is. On the same note, my internal Reviewed-by also mean nothing as they
were done against a different kernel.

regards
Suman

> 
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c |   15 ++++++++++++++
>  arch/arm/mach-omap2/pdata-quirks.c        |   11 ++++++++++
>  arch/arm/mach-omap2/prm7xx.h              |    1 +
>  drivers/pci/host/pci-dra7xx.c             |   32 +++++++++++++++++++++++++++++
>  include/linux/platform_data/pci-dra7xx.h  |   22 ++++++++++++++++++++
>  5 files changed, 81 insertions(+)
>  create mode 100644 include/linux/platform_data/pci-dra7xx.h
> 
