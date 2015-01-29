From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 30 Jan 2015 09:55:33 +1100
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20150130095533.315d3831@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/Kconfig.debug between commit 4d31e6641295 ("ARM: 8272/1: netx:
Migrate DEBUG_LL macros to shared directory") from the  tree and
commits 01ea63d99397 ("ARM: sirf: add two debug ports for CSRatlas7
SoC") and e23814da8262 ("ARM: digicolor: add low level debug support")
from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/Kconfig.debug
index a324ecdfeb21,b6a073de1559..000000000000
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@@ -1448,17 -1461,15 +1517,19 @@@ config DEBUG_UART_VIR
  	default 0xfef00000 if ARCH_IXP4XX && !CPU_BIG_ENDIAN
  	default 0xfef00003 if ARCH_IXP4XX && CPU_BIG_ENDIAN
  	default 0xfef36000 if DEBUG_HIGHBANK_UART
 +	default 0xfefb0000 if DEBUG_OMAP1UART1 || DEBUG_OMAP7XXUART1
 +	default 0xfefb0800 if DEBUG_OMAP1UART2 || DEBUG_OMAP7XXUART2
 +	default 0xfefb9800 if DEBUG_OMAP1UART3 || DEBUG_OMAP7XXUART3
  	default 0xfefff700 if ARCH_IOP33X
  	default 0xff003000 if DEBUG_U300_UART
+ 	default 0xffd01000 if DEBUG_HIP01_UART
  	default DEBUG_UART_PHYS if !MMU
  	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
  		DEBUG_UART_8250 || DEBUG_UART_PL01X || DEBUG_MESON_UARTAO || \
 -		DEBUG_MSM_UART || DEBUG_QCOM_UARTDM || DEBUG_S3C24XX_UART || \
 +		DEBUG_MSM_UART || DEBUG_NETX_UART || \
 +		DEBUG_QCOM_UARTDM || DEBUG_S3C24XX_UART || \
- 		DEBUG_UART_BCM63XX || DEBUG_ASM9260_UART
+ 		DEBUG_UART_BCM63XX || DEBUG_ASM9260_UART || \
+ 		DEBUG_SIRFSOC_UART || DEBUG_DIGICOLOR_UA0
  
  config DEBUG_UART_8250_SHIFT
  	int "Register offset shift for the 8250 debug UART"
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150130/8fc8fd65/attachment.sig>
