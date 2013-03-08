From: hechtb@gmail.com (Bastian Hecht)
Date: Fri,  8 Mar 2013 12:29:40 +0100
Subject: [PATCH v2 6/7] ARM: shmobile: r8a7740: Add DT name to clock list for
 CMT10
In-Reply-To: <1362742181-19111-1-git-send-email-hechtb+renesas@gmail.com>
References: <1362742181-19111-1-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <1362742181-19111-7-git-send-email-hechtb+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds temporarily the alternative device name to the clock list
that is used when booting via Device Tree setup.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
v2: new

I can rebase this on topic/intc-of if wanted.

 arch/arm/mach-shmobile/clock-r8a7740.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index 1feb9a2..b0b5d3c 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -616,6 +616,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("e6cc0000.sci",		&mstp_clks[MSTP230]),
 
 	CLKDEV_DEV_ID("sh_cmt.10",		&mstp_clks[MSTP329]),
+	CLKDEV_DEV_ID("e6138010.timer",		&mstp_clks[MSTP329]),
 	CLKDEV_DEV_ID("sh_fsi2",		&mstp_clks[MSTP328]),
 	CLKDEV_DEV_ID("i2c-sh_mobile.1",	&mstp_clks[MSTP323]),
 	CLKDEV_DEV_ID("renesas_usbhs",		&mstp_clks[MSTP320]),
-- 
1.7.9.5
