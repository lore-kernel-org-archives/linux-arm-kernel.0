From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu,  1 Mar 2012 14:10:25 +0800
Subject: [PATCH 5/8] ARM: mmp: enable rtc clk in pxa168
In-Reply-To: <1330582228-12424-1-git-send-email-haojian.zhuang@marvell.com>
References: <1330582228-12424-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1330582228-12424-6-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable clk of rtc-sa1100 device in pxa168.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/pxa168.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 9f61256..aa62d0c 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -65,6 +65,7 @@ static APBC_CLK(ssp4, PXA168_SSP4, 4, 0);
 static APBC_CLK(ssp5, PXA168_SSP5, 4, 0);
 static APBC_CLK(gpio, PXA168_GPIO, 0, 13000000);
 static APBC_CLK(keypad, PXA168_KPC, 0, 32000);
+static APBC_CLK(rtc, PXA168_RTC, 8, 32768);
 
 static APMU_CLK(nand, NAND, 0x19b, 156000000);
 static APMU_CLK(lcd, LCD, 0x7f, 312000000);
@@ -93,6 +94,7 @@ static struct clk_lookup pxa168_clkregs[] = {
 	INIT_CLKREG(&clk_keypad, "pxa27x-keypad", NULL),
 	INIT_CLKREG(&clk_eth, "pxa168-eth", "MFUCLK"),
 	INIT_CLKREG(&clk_usb, "pxa168-ehci", "PXA168-USBCLK"),
+	INIT_CLKREG(&clk_rtc, "sa1100-rtc", NULL),
 };
 
 static int __init pxa168_init(void)
-- 
1.7.0.4
