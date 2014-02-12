From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 12 Feb 2014 16:59:28 +0100
Subject: [PATCH v3 05/13] pinctrl: mvebu: add common mpp reg defines to mvebu
 pinctrl include
In-Reply-To: <1392220776-30851-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1390869573-27624-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1392220776-30851-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1392220776-30851-6-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds some defines for the common mpp reg layout to mvebu pinctrl
include.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Tested-by: Andrew Lunn <andrew@lunn.ch>
---
Cc: Linus Walleij <linus.walleij@linaro.org> 
Cc: Jason Cooper <jason@lakedaemon.net> 
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/pinctrl/mvebu/pinctrl-mvebu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pinctrl/mvebu/pinctrl-mvebu.h b/drivers/pinctrl/mvebu/pinctrl-mvebu.h
index b20d1d778c75..41feceb2fa4f 100644
--- a/drivers/pinctrl/mvebu/pinctrl-mvebu.h
+++ b/drivers/pinctrl/mvebu/pinctrl-mvebu.h
@@ -186,6 +186,10 @@ struct mvebu_pinctrl_soc_info {
 		.npins = _npins,				\
 	}
 
+#define MVEBU_MPPS_PER_REG	8
+#define MVEBU_MPP_BITS		4
+#define MVEBU_MPP_MASK		0xf
+
 int mvebu_pinctrl_probe(struct platform_device *pdev);
 int mvebu_pinctrl_remove(struct platform_device *pdev);
 
-- 
1.8.5.3
