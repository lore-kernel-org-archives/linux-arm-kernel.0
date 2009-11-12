From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 12 Nov 2009 11:41:58 +0100
Subject: [PATCH 2/9] MXC NFC: Fix NFCs address area on i.MX35
In-Reply-To: <1258022525-21078-2-git-send-email-s.hauer@pengutronix.de>
References: <1258022525-21078-1-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1258022525-21078-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Juergen Beisert <jbe@pengutronix.de>

The address area of the NFS in the i.MX35 silicon is much larger than 4k.

Signed-off-by: Juergen Beisert <j.beisert@pengutronix.de>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/devices.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index 8a577f3..f007f22 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -546,7 +546,7 @@ static int mx3_devices_init(void)
 	}
 	if (cpu_is_mx35()) {
 		mxc_nand_resources[0].start = MX35_NFC_BASE_ADDR;
-		mxc_nand_resources[0].end = MX35_NFC_BASE_ADDR + 0xfff;
+		mxc_nand_resources[0].end = MX35_NFC_BASE_ADDR + 0x1fff;
 		otg_resources[0].start = MX35_OTG_BASE_ADDR;
 		otg_resources[0].end = MX35_OTG_BASE_ADDR + 0x1ff;
 		otg_resources[1].start = MXC_INT_USBOTG;
-- 
1.6.5.2
