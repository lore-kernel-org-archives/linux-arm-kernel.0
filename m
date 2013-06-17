From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 17 Jun 2013 16:39:20 +1000
Subject: linux-next: manual merge of the arm-soc tree with the net-next tree
Message-ID: <20130617163920.04523ba6de50bcc81563f33e@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-shmobile/clock-r8a7740.c between commit e5c9b4cd6651
("sh_eth: get R8A7740 support out of #ifdef") from the net-next tree and
commit 9e0b428f079d ("ARM: shmobile: r8a7740: Add interim sh-eth device
name to clocks list") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-shmobile/clock-r8a7740.c
index ae93f94,7fd32d6..0000000
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@@ -591,7 -594,9 +594,9 @@@ static struct clk_lookup lookups[] = 
  	CLKDEV_DEV_ID("e6860000.sdhi",          &mstp_clks[MSTP313]),
  	CLKDEV_DEV_ID("sh_mmcif",		&mstp_clks[MSTP312]),
  	CLKDEV_DEV_ID("e6bd0000.mmcif",         &mstp_clks[MSTP312]),
 -	CLKDEV_DEV_ID("sh-eth",			&mstp_clks[MSTP309]),
 +	CLKDEV_DEV_ID("r8a7740-gether",		&mstp_clks[MSTP309]),
+ 	CLKDEV_DEV_ID("e9a00000.sh-eth",	&mstp_clks[MSTP309]),
+ 	CLKDEV_DEV_ID("renesas_tpu_pwm",	&mstp_clks[MSTP304]),
  
  	CLKDEV_DEV_ID("sh_mobile_sdhi.2",	&mstp_clks[MSTP415]),
  	CLKDEV_DEV_ID("e6870000.sdhi",          &mstp_clks[MSTP415]),
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130617/bb543429/attachment-0001.sig>
