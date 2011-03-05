From: mspang@csclub.uwaterloo.ca (Michael Spang)
Date: Fri,  4 Mar 2011 23:39:16 -0500
Subject: [PATCH 1/2] ARM: Add TS-7800 revisions 6-9
Message-ID: <1299299957-13018-1-git-send-email-mspang@csclub.uwaterloo.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RTC, NAND, and RNG devices are not enabled on current TS-7800s.
The manufacturer is at revision 9 (at least), and they do support
these devices. We'll assume revisions 6 through 8 do as well.

Signed-off-by: Michael Spang <mspang@csclub.uwaterloo.ca>
---
 arch/arm/mach-orion5x/ts78xx-fpga.h  |    4 ++++
 arch/arm/mach-orion5x/ts78xx-setup.c |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-orion5x/ts78xx-fpga.h b/arch/arm/mach-orion5x/ts78xx-fpga.h
index 37b3d48..791f754 100644
--- a/arch/arm/mach-orion5x/ts78xx-fpga.h
+++ b/arch/arm/mach-orion5x/ts78xx-fpga.h
@@ -11,6 +11,10 @@ enum fpga_ids {
 	TS7800_REV_3	= FPGAID(0x00b480, 0x03),
 	TS7800_REV_4	= FPGAID(0x00b480, 0x04),
 	TS7800_REV_5	= FPGAID(0x00b480, 0x05),
+	TS7800_REV_6	= FPGAID(0x00b480, 0x06),
+	TS7800_REV_7	= FPGAID(0x00b480, 0x07),
+	TS7800_REV_8	= FPGAID(0x00b480, 0x08),
+	TS7800_REV_9	= FPGAID(0x00b480, 0x09),
 
 	/* Unaffordable & Expensive */
 	UAE_DUMMY	= FPGAID(0xffffff, 0x01),
diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index c1c1cd0..7bed418 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -334,6 +334,10 @@ static void ts78xx_fpga_supports(void)
 	case TS7800_REV_3:
 	case TS7800_REV_4:
 	case TS7800_REV_5:
+	case TS7800_REV_6:
+	case TS7800_REV_7:
+	case TS7800_REV_8:
+	case TS7800_REV_9:
 		ts78xx_fpga.supports.ts_rtc.present = 1;
 		ts78xx_fpga.supports.ts_nand.present = 1;
 		ts78xx_fpga.supports.ts_rng.present = 1;
-- 
1.7.2.3
