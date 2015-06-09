From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Jun 2015 18:47:00 +0200
Subject: [PATCH 08/34] pinctrl: mvebu: armada-38x: fix incorrect total number
 of GPIOs
In-Reply-To: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1433868446-11028-9-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pinctrl_gpio_range[] array described a first bank of 32 GPIOs and
a second one of 27 GPIOs. However, since there is a total of 60 MPP
pins that can be muxed as GPIOs, the second bank really has 28 GPIOs.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: <stable@vger.kernel.org> # v3.15+
Fixes: ca6d9a084b56f ("pinctrl: mvebu: add pin-muxing driver for the Marvell Armada 380/385")
---
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
index 11656c7..ff411a5 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
@@ -402,7 +402,7 @@ static struct mvebu_mpp_ctrl armada_38x_mpp_controls[] = {
 
 static struct pinctrl_gpio_range armada_38x_mpp_gpio_ranges[] = {
 	MPP_GPIO_RANGE(0,   0,  0, 32),
-	MPP_GPIO_RANGE(1,  32, 32, 27),
+	MPP_GPIO_RANGE(1,  32, 32, 28),
 };
 
 static int armada_38x_pinctrl_probe(struct platform_device *pdev)
-- 
2.1.0
