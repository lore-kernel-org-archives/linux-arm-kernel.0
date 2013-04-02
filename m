From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 2 Apr 2013 17:55:57 +1100
Subject: linux-next: manual merge of the imx-mxs tree with the arm-soc tree
Message-ID: <20130402175557.e44f384205d2d32dcd95be1d@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Today's linux-next merge of the imx-mxs tree got a conflict in
arch/arm/Kconfig.debug between commit 266c347924f5 ("ARM: nomadik: move
debugmacro to debug includes") from the arm-soc tree and commit
11c6f861cf3a ("ARM: mxs: rename debug-macro.S for multiplatform build")
from the imx-mxs tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/Kconfig.debug
index d212ae0,057601e..0000000
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@@ -611,10 -591,9 +611,11 @@@ config DEBUG_LL_INCLUD
  				 DEBUG_IMX6Q_UART
  	default "debug/highbank.S" if DEBUG_HIGHBANK_UART
  	default "debug/mvebu.S" if DEBUG_MVEBU_UART
 +	default "debug/nomadik.S" if DEBUG_NOMADIK_UART
+ 	default "debug/mxs.S" if DEBUG_IMX23_UART || DEBUG_IMX28_UART
  	default "debug/omap2plus.S" if DEBUG_OMAP2PLUS_UART
  	default "debug/picoxcell.S" if DEBUG_PICOXCELL_UART
 +	default "debug/sirf.S" if DEBUG_SIRFPRIMA2_UART1 || DEBUG_SIRFMARCO_UART1
  	default "debug/socfpga.S" if DEBUG_SOCFPGA_UART
  	default "debug/sunxi.S" if DEBUG_SUNXI_UART0 || DEBUG_SUNXI_UART1
  	default "debug/vexpress.S" if DEBUG_VEXPRESS_UART0_DETECT || \
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130402/a3f6c36b/attachment.sig>
