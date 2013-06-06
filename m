From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 6 Jun 2013 15:36:00 +1000
Subject: linux-next: manual merge of the mvebu tree with the imx-mxs tree
Message-ID: <20130606153600.a23c3489dc8b30d0836cb8ea@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the mvebu tree got a conflict in
arch/arm/Kconfig.debug between commit 284166ffebc3 ("ARM: imx: enable
low-level debug support for imx6sl") from the imx-mxs tree and commit
5be22d8c29fd ("arm: mvebu: add another earlyprintk Kconfig option") from
the mvebu tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/Kconfig.debug
index 29f7623,e6a6ab1..0000000
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@@ -639,9 -656,9 +664,10 @@@ config DEBUG_LL_INCLUD
  				 DEBUG_IMX35_UART || \
  				 DEBUG_IMX51_UART || \
  				 DEBUG_IMX53_UART ||\
 -				 DEBUG_IMX6Q_UART
 +				 DEBUG_IMX6Q_UART || \
 +				 DEBUG_IMX6SL_UART
- 	default "debug/mvebu.S" if DEBUG_MVEBU_UART
+ 	default "debug/mvebu.S" if DEBUG_MVEBU_UART || \
+ 				   DEBUG_MVEBU_UART_ALTERNATE
  	default "debug/mxs.S" if DEBUG_IMX23_UART || DEBUG_IMX28_UART
  	default "debug/nomadik.S" if DEBUG_NOMADIK_UART
  	default "debug/omap2plus.S" if DEBUG_OMAP2PLUS_UART
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130606/6df852d7/attachment.sig>
