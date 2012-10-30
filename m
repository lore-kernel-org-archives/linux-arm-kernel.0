From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 30 Oct 2012 15:06:27 +1100
Subject: linux-next: manual merge of the clk tree with the arm-soc tree
Message-ID: <20121030150627.ac1f6a3f75231ea49edf7b98@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Today's linux-next merge of the clk tree got a conflict in
arch/arm/include/asm/hardware/sp810.h between commit 0891642cf117 ("ARM:
vexpress: Start using new Versatile Express infrastructure") from the
arm-soc tree and commit 05e3659135a4 ("clk: Common clocks implementation
for Versatile Express") from the clk tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/include/asm/hardware/sp810.h
index 2cdcf44,afd7e91..0000000
--- a/arch/arm/include/asm/hardware/sp810.h
+++ b/arch/arm/include/asm/hardware/sp810.h
@@@ -50,6 -50,14 +50,8 @@@
  #define SCPCELLID2		0xFF8
  #define SCPCELLID3		0xFFC
  
 -#define SCCTRL_TIMEREN0SEL_REFCLK	(0 << 15)
 -#define SCCTRL_TIMEREN0SEL_TIMCLK	(1 << 15)
 -
 -#define SCCTRL_TIMEREN1SEL_REFCLK	(0 << 17)
 -#define SCCTRL_TIMEREN1SEL_TIMCLK	(1 << 17)
 -
+ #define SCCTRL_TIMERENnSEL_SHIFT(n)	(15 + ((n) * 2))
+ 
  static inline void sysctl_soft_reset(void __iomem *base)
  {
  	/* switch to slow mode */
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121030/0d88bf1b/attachment.sig>
