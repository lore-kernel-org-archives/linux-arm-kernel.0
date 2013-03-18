From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 18 Mar 2013 15:06:28 +1100
Subject: linux-next: manual merge of the bcm2835 tree with the arm-soc tree
Message-ID: <20130318150628.82d6a8a23fcb36d881764399@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Today's linux-next merge of the bcm2835 tree got a conflict in
arch/arm/Kconfig.debug between commit 29c9b7be7574 ("ARM: cns3xxx: move
debug_ll code to include/debug/") from the arm-soc tree and commit
f1ac922dec7e ("ARM: bcm2835: convert to multi-platform") from the bcm2835
tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/Kconfig.debug
index bce30a8,a877d51..0000000
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@@ -593,7 -583,7 +597,8 @@@ endchoic
  
  config DEBUG_LL_INCLUDE
  	string
+ 	default "debug/bcm2835.S" if DEBUG_BCM2835
 +	default "debug/cns3xxx.S" if DEBUG_CNS3XXX
  	default "debug/icedcc.S" if DEBUG_ICEDCC
  	default "debug/imx.S" if DEBUG_IMX1_UART || \
  				 DEBUG_IMX25_UART || \
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130318/74c2c36b/attachment.sig>
