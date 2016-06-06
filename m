From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 6 Jun 2016 11:42:12 -0700
Subject: [PATCH v4 7/7] phy: Add Northstar2 PCI Phy support
In-Reply-To: <1465216900-11755-8-git-send-email-pramod.kumar@broadcom.com>
References: <1465216900-11755-1-git-send-email-pramod.kumar@broadcom.com>
 <1465216900-11755-8-git-send-email-pramod.kumar@broadcom.com>
Message-ID: <5755C404.3080502@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2016 05:41 AM, Pramod Kumar wrote:
> Add PCI Phy support for Broadcom Northstar2 SoCs.  This driver uses the
> interface from the iproc mdio mux driver to enable the devices
> respective phys.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Jon Mason <jonmason@broadcom.com>
> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
> ---
>  drivers/phy/Kconfig            |   8 +++
>  drivers/phy/Makefile           |   2 +-
>  drivers/phy/phy-bcm-ns2-pcie.c | 115 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 124 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/phy/phy-bcm-ns2-pcie.c
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index b869b98..01fb93b 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -434,4 +434,12 @@ config PHY_CYGNUS_PCIE
>  
>  source "drivers/phy/tegra/Kconfig"
>  
> +config PHY_NS2_PCIE
> +	tristate "Broadcom Northstar2 PCIe PHY driver"
> +	depends on OF && MDIO_BUS_MUX_BCM_IPROC
> +	select GENERIC_PHY
> +	default ARCH_BCM_IPROC

Are not you missing a dependency on PHYLIB too to provide
mdio_module_register() etc. (at least make it build)?

-- 
Florian
