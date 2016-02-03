From: k@japko.eu (Krzysztof Adamski)
Date: Wed, 3 Feb 2016 08:57:14 +0100
Subject: [PATCH v2] pinctrl: sunxi: H3 requires irq_read_needs_mux
Message-ID: <20160203075713.GA23312@box2.japko.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It seems that on H3, just like on A10, when GPIOs are configured as
external interrupt data registers does not contain their value.  When
value is read, GPIO function must be temporary switched to input for
reads.

Signed-off-by: Krzysztof Adamski <k@japko.eu>
---

Changes compared to v1:
- None, but the patch was sent with wrong "From:", if you want to apply 
  it, please apply this one. Sorry for confusion.


 drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c
index 77d4cf0..11760bb 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c
@@ -492,6 +492,7 @@ static const struct sunxi_pinctrl_desc sun8i_h3_pinctrl_data = {
 	.pins = sun8i_h3_pins,
 	.npins = ARRAY_SIZE(sun8i_h3_pins),
 	.irq_banks = 2,
+	.irq_read_needs_mux = true
 };
 
 static int sun8i_h3_pinctrl_probe(struct platform_device *pdev)
-- 
2.4.2
