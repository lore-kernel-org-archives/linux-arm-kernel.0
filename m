From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 6 Jan 2014 10:20:31 +1100
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20140106102031.8ecedbad59dddbc8aa0946ce@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/Kconfig.debug between commit 753d12434da3 ("ARM: 7932/1: bcm:
Add DEBUG_LL console support") from the arm tree and commit caad0b41de69
("ARM: add Marvell Berlin UART0 lowlevel debug") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell <sfr@canb.auug.org.au>

diff --cc arch/arm/Kconfig.debug
index 9afabbb5e798,bda94e46e8d6..000000000000
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@@ -106,17 -94,14 +106,25 @@@ choic
  		depends on ARCH_BCM2835
  		select DEBUG_UART_PL01X
  
 +	config DEBUG_BCM_KONA_UART
 +		bool "Kernel low-level debugging messages via BCM KONA UART"
 +		depends on ARCH_BCM
 +		select DEBUG_UART_8250
 +		help
 +		  Say Y here if you want kernel low-level debugging support
 +		  on Broadcom SoC platforms.
 +		  This low level debug works for Broadcom
 +		  mobile SoCs in the Kona family of chips (e.g. bcm28155,
 +		  bcm11351, etc...)
 +
+ 	config DEBUG_BERLIN_UART
+ 		bool "Marvell Berlin SoC Debug UART"
+ 		depends on ARCH_BERLIN
+ 		select DEBUG_UART_8250
+ 		help
+ 		  Say Y here if you want kernel low-level debugging support
+ 		  on Marvell Berlin SoC based platforms.
+ 
  	config DEBUG_CLPS711X_UART1
  		bool "Kernel low-level debugging messages via UART1"
  		depends on ARCH_CLPS711X
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140106/f5ad351e/attachment.sig>
