From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 17 Jul 2014 12:01:01 +1000
Subject: linux-next: manual merge of the samsung tree with the arm-soc tree
Message-ID: <20140717120101.52a8ce26@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

Today's linux-next merge of the samsung tree got a conflict in
arch/arm/plat-samsung/Kconfig between commit ab275b132a79 ("ARM: s5p:
cut the custom ARCH_NR_GPIOS definition") from the arm-soc tree and
commit 2722091e711f ("ARM: SAMSUNG: Remove remaining legacy code") from
the samsung tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/plat-samsung/Kconfig
index 6910c8669742,1091b0a3729a..000000000000
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@@ -65,48 -51,22 +51,6 @@@ config SAMSUNG_ATAG
  
  if SAMSUNG_ATAGS
  
- # clock options
- 
- config SAMSUNG_CLOCK
- 	bool
- 	default y if !COMMON_CLK
- 
- config SAMSUNG_CLKSRC
- 	bool
- 	help
- 	  Select the clock code for the clksrc implementation
- 	  used by newer systems such as the S3C64XX.
- 
- config S5P_CLOCK
- 	def_bool ARCH_S5PV210
- 	help
- 	  Support common clock part for ARCH_S5P and ARCH_EXYNOS SoCs
- 
- # options for IRQ support
- 
- config S5P_IRQ
- 	def_bool ARCH_S5PV210
- 	help
- 	  Support common interrupt part for ARCH_S5P SoCs
- 
- config S5P_EXT_INT
- 	bool
 -config SAMSUNG_GPIO_EXTRA
 -	int "Number of additional GPIO pins"
 -	default 128 if SAMSUNG_GPIO_EXTRA128
 -	default 64 if SAMSUNG_GPIO_EXTRA64
 -	default 0
--	help
- 	  Use the external interrupts (other than GPIO interrupts.)
 -	  Use additional GPIO space in addition to the GPIO's the SOC
 -	  provides. This allows expanding the GPIO space for use with
 -	  GPIO expanders.
--
- config S5P_GPIO_INT
 -config SAMSUNG_GPIO_EXTRA64
--	bool
- 	help
- 	  Common code for the GPIO interrupts (other than external interrupts.)
- 
- # options for gpio configuration support
--
- config S5P_GPIO_DRVSTR
 -config SAMSUNG_GPIO_EXTRA128
--	bool
- 	help
- 	  Internal configuration to get and set correct GPIO driver strength
- 	  helper
--
  config S3C_GPIO_SPACE
  	int "Space between gpio banks"
  	default 0
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140717/0d6241b8/attachment.sig>
