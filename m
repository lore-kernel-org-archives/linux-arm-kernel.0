From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Jun 2015 18:46:54 +0200
Subject: [PATCH 02/34] pinctrl: mvebu: armada-370: fix spi0 pin description
In-Reply-To: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1433868446-11028-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to a mistake, the CS0 and CS1 SPI0 functions were incorrectly
named "spi0-1" instead of just "spi0". This commit fixes that.

This DT binding change does not affect any of the in-tree users.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: <stable@vger.kernel.org> # v3.7+
Fixes: 5f597bb2be57 ("pinctrl: mvebu: add pinctrl driver for Armada 370")
---
 .../devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt        | 4 ++--
 drivers/pinctrl/mvebu/pinctrl-armada-370.c                            | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
index adda2a8..e357b02 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
@@ -92,5 +92,5 @@ mpp61         61       gpo, dev(wen1), uart1(txd), audio(rclk)
 mpp62         62       gpio, dev(a2), uart1(cts), tdm(drx), pcie(clkreq0),
                        audio(mclk), uart0(cts)
 mpp63         63       gpo, spi0(sck), tclk
-mpp64         64       gpio, spi0(miso), spi0-1(cs1)
-mpp65         65       gpio, spi0(mosi), spi0-1(cs2)
+mpp64         64       gpio, spi0(miso), spi0(cs1)
+mpp65         65       gpio, spi0(mosi), spi0(cs2)
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-370.c b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
index 03aa58c..1eb084c 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-370.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
@@ -370,11 +370,11 @@ static struct mvebu_mpp_mode mv88f6710_mpp_modes[] = {
 	MPP_MODE(64,
 	   MPP_FUNCTION(0x0, "gpio", NULL),
 	   MPP_FUNCTION(0x1, "spi0", "miso"),
-	   MPP_FUNCTION(0x2, "spi0-1", "cs1")),
+	   MPP_FUNCTION(0x2, "spi0", "cs1")),
 	MPP_MODE(65,
 	   MPP_FUNCTION(0x0, "gpio", NULL),
 	   MPP_FUNCTION(0x1, "spi0", "mosi"),
-	   MPP_FUNCTION(0x2, "spi0-1", "cs2")),
+	   MPP_FUNCTION(0x2, "spi0", "cs2")),
 };
 
 static struct mvebu_pinctrl_soc_info armada_370_pinctrl_info;
-- 
2.1.0
