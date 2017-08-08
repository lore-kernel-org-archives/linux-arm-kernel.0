From: prabhakar.kushwaha@nxp.com (Prabhakar Kushwaha)
Date: Tue, 8 Aug 2017 08:30:49 +0000
Subject: [U-Boot] [PATCH] config: ls1012aqds: Add USB EHCI support for
 ls1012aqds
In-Reply-To: <1501148945-11775-1-git-send-email-yinbo.zhu@nxp.com>
References: <1501148945-11775-1-git-send-email-yinbo.zhu@nxp.com>
Message-ID: <HE1PR04MB12410A493E08EB27A2F77F66978A0@HE1PR04MB1241.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: U-Boot [mailto:u-boot-bounces at lists.denx.de] On Behalf Of
> yinbo.zhu at nxp.com
> Sent: Thursday, July 27, 2017 3:19 PM
> To: u-boot at lists.denx.de
> Cc: open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree@vger.kernel.org>; Mihai Emilian Bantea <mihai.bantea@nxp.com>;
> Horia Geant? <horia.geanta@nxp.com>; Marc Zyngier
> <marc.zyngier@arm.com>; Gang Liu <gang.liu@nxp.com>; open list <linux-
> kernel at vger.kernel.org>; Scott Wood <oss@buserror.net>; Rajat Srivastava
> <rajat.srivastava@nxp.com>; Yinbo Zhu <yinbo.zhu@nxp.com>; moderated
> list:ARM64 PORT (AARCH64 ARCHITECTURE) <linux-arm-
> kernel at lists.infradead.org>
> Subject: [U-Boot] [PATCH] config: ls1012aqds: Add USB EHCI support for
> ls1012aqds
> 
> From: Rajesh Bhagat <rajesh.bhagat@nxp.com>
> 
> Add USB EHCI support for ls1012aqds platform
> 
> Signed-off-by: Rajat Srivastava <rajat.srivastava@nxp.com>
> Signed-off-by: Rajesh Bhagat <rajesh.bhagat@nxp.com>
> Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
> ---
>  arch/arm/include/asm/arch-fsl-layerscape/immap_lsch2.h | 1 +
>  include/configs/ls1012aqds.h                           | 2 ++
>  include/usb/ehci-ci.h                                  | 2 +-
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/arch-fsl-layerscape/immap_lsch2.h
> b/arch/arm/include/asm/arch-fsl-layerscape/immap_lsch2.h
> index 8ad199f..4afc338 100644
> --- a/arch/arm/include/asm/arch-fsl-layerscape/immap_lsch2.h
> +++ b/arch/arm/include/asm/arch-fsl-layerscape/immap_lsch2.h
> @@ -35,6 +35,7 @@
>  #define CONFIG_SYS_XHCI_USB1_ADDR		(CONFIG_SYS_IMMR +
> 0x01f00000)
>  #define CONFIG_SYS_XHCI_USB2_ADDR		(CONFIG_SYS_IMMR +
> 0x02000000)
>  #define CONFIG_SYS_XHCI_USB3_ADDR		(CONFIG_SYS_IMMR +
> 0x02100000)
> +#define CONFIG_SYS_EHCI_USB1_ADDR		(CONFIG_SYS_IMMR +
> 0x07600000)
>  #define CONFIG_SYS_PCIE1_ADDR			(CONFIG_SYS_IMMR +
> 0x2400000)
>  #define CONFIG_SYS_PCIE2_ADDR			(CONFIG_SYS_IMMR +
> 0x2500000)
>  #define CONFIG_SYS_PCIE3_ADDR			(CONFIG_SYS_IMMR +
> 0x2600000)
> diff --git a/include/configs/ls1012aqds.h b/include/configs/ls1012aqds.h
> index 5b8500b..55f2578 100644
> --- a/include/configs/ls1012aqds.h
> +++ b/include/configs/ls1012aqds.h
> @@ -115,6 +115,8 @@
> 
>  #ifdef CONFIG_HAS_FSL_DR_USB
>  #define CONFIG_USB_EHCI_FSL
> +#define CONFIG_USB_ULPI
> +#define CONFIG_USB_ULPI_VIEWPORT
>  #define CONFIG_EHCI_HCD_INIT_AFTER_RESET
>  #endif
> 
> diff --git a/include/usb/ehci-ci.h b/include/usb/ehci-ci.h
> index 847b698..cd3eb47 100644
> --- a/include/usb/ehci-ci.h
> +++ b/include/usb/ehci-ci.h
> @@ -156,7 +156,7 @@
>  #elif defined(CONFIG_MPC85xx)
>  #define CONFIG_SYS_FSL_USB1_ADDR CONFIG_SYS_MPC85xx_USB1_ADDR
>  #define CONFIG_SYS_FSL_USB2_ADDR CONFIG_SYS_MPC85xx_USB2_ADDR
> -#elif defined(CONFIG_ARCH_LS1021A)
> +#elif defined(CONFIG_LS102XA) || defined(CONFIG_ARCH_LS1012A)

Why CONFIG_ARCH_LS1021A has been replaced by CONFIG_LS102XA?

-prabhakar
