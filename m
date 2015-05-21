From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 21 May 2015 10:58:56 +1000
Subject: linux-next: manual merge of the imx-mxs tree with the arm-soc tree
Message-ID: <20150521105856.1a076b4a@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Today's linux-next merge of the imx-mxs tree got a conflict in
arch/arm/mach-imx/Kconfig between commit 8064887e02fd ("ARM: vf610:
enable Cortex-M4 configuration on Vybrid SoC") from the arm-soc tree
and commit aff62955b27b ("ARM: imx: add msl support for imx7d") from
the imx-mxs tree.

I fixed it up (hopefully - see below) and can carry the fix as
necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-imx/Kconfig
index 2e3c45832674,b8e05379311e..000000000000
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@@ -582,24 -548,17 +548,31 @@@ config SOC_IMX6S
  	help
  	  This enables support for Freescale i.MX6 SoloX processor.
  
+ config SOC_IMX7D
+ 	bool "i.MX7 Dual support"
+ 	select PINCTRL_IMX7D
+ 	select ARM_GIC
+ 	help
+ 		This enables support for Freescale i.MX7 Dual processor.
+ 
 +config SOC_LS1021A
 +	bool "Freescale LS1021A support"
 +	select ARM_GIC
 +	select HAVE_ARM_ARCH_TIMER
 +	select PCI_DOMAINS if PCI
 +	select ZONE_DMA if ARM_LPAE
 +	help
 +	  This enables support for Freescale LS1021A processor.
 +
 +endif
 +
 +comment "Cortex-A/Cortex-M asymmetric multiprocessing platforms"
 +
 +if ARCH_MULTI_V7 || ARM_SINGLE_ARMV7M
 +
  config SOC_VF610
  	bool "Vybrid Family VF610 support"
 -	select IRQ_DOMAIN_HIERARCHY
 -	select ARM_GIC
 +	select ARM_GIC if ARCH_MULTI_V7
  	select PINCTRL_VF610
  	select PL310_ERRATA_769419 if CACHE_L2X0
  	select SMP_ON_UP if SMP
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150521/ac598381/attachment-0001.sig>
