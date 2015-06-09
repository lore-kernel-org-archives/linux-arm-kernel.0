From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Jun 2015 18:46:56 +0200
Subject: [PATCH 04/34] pinctrl: mvebu: armada-xp: remove non-existing NAND pins
In-Reply-To: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1433868446-11028-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After updating to a more recent version of the Armada XP datasheet, we
realized that some of the pins documented as having a NAND-related
functionality in fact did not have such functionality. This commit
updates the pinctrl driver accordingly.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: <stable@vger.kernel.org> # v3.7+
Fixes: 463e270f766a ("pinctrl: mvebu: add pinctrl driver for Armada XP")
---
 .../devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt         | 4 ++--
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c                             | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
index 373dbccd..974168d 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
@@ -42,8 +42,8 @@ mpp20         20       gpio, ge0(rxd4), ge1(rxd2), lcd(d20), ptp(clk)
 mpp21         21       gpio, ge0(rxd5), ge1(rxd3), lcd(d21), mem(bat)
 mpp22         22       gpio, ge0(rxd6), ge1(rxctl), lcd(d22), sata0(prsnt)
 mpp23         23       gpio, ge0(rxd7), ge1(rxclk), lcd(d23), sata1(prsnt)
-mpp24         24       gpio, lcd(hsync), sata1(prsnt), nf(bootcs-re), tdm(rst)
-mpp25         25       gpio, lcd(vsync), sata0(prsnt), nf(bootcs-we), tdm(pclk)
+mpp24         24       gpio, lcd(hsync), sata1(prsnt), tdm(rst)
+mpp25         25       gpio, lcd(vsync), sata0(prsnt), tdm(pclk)
 mpp26         26       gpio, lcd(clk), tdm(fsync), vdd(cpu1-pd)
 mpp27         27       gpio, lcd(e), tdm(dtx), ptp(trig)
 mpp28         28       gpio, lcd(pwm), tdm(drx), ptp(evreq)
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
index 578db9f..7310c40 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
@@ -172,13 +172,11 @@ static struct mvebu_mpp_mode armada_xp_mpp_modes[] = {
 	MPP_MODE(24,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x1, "sata1", "prsnt",    V_MV78230_PLUS),
-		 MPP_VAR_FUNCTION(0x2, "nf", "bootcs-re",   V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x3, "tdm", "rst",        V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x4, "lcd", "hsync",      V_MV78230_PLUS)),
 	MPP_MODE(25,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x1, "sata0", "prsnt",    V_MV78230_PLUS),
-		 MPP_VAR_FUNCTION(0x2, "nf", "bootcs-we",   V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x3, "tdm", "pclk",       V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x4, "lcd", "vsync",      V_MV78230_PLUS)),
 	MPP_MODE(26,
-- 
2.1.0
