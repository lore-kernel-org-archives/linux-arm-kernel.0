From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:24:55 +0900
Subject: [PATCH 004/130] gpio-rcar: Add RCAR_GP_PIN macro
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Pins are numbered in the R-Car family documentation using a bank number
and a pin number in the bank. As the Linux pin number space is linear,
we need to flatten this by multiplying the bank number by 32 and adding
the pin number. The resulting number bear no directly visible
relationship  to the documentation, making it error-prone.

Add a RCAR_GP_PIN macro to convert from the documentation pin number
space to the linear Linux space.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
[horms+renesas at verge.net.au: non-trivial rebase on top of
 "sh-pfc: r8a7779: Don't group USB OVC and PENC pins"]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 include/linux/platform_data/gpio-rcar.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/platform_data/gpio-rcar.h b/include/linux/platform_data/gpio-rcar.h
index 6c0027a..2d8d694 100644
--- a/include/linux/platform_data/gpio-rcar.h
+++ b/include/linux/platform_data/gpio-rcar.h
@@ -24,4 +24,6 @@ struct gpio_rcar_config {
 	unsigned has_both_edge_trigger:1;
 };
 
+#define RCAR_GP_PIN(bank, pin)		(((bank) * 32) + (pin))
+
 #endif /* __GPIO_RCAR_H__ */
-- 
1.8.2.1
