From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 16 Apr 2012 22:07:24 +0800
Subject: [PATCH 2/3] pinctrl: a minor fix of pin config debug information
In-Reply-To: <1334585244-10249-1-git-send-email-b29396@freescale.com>
References: <1334585244-10249-1-git-send-email-b29396@freescale.com>
Message-ID: <1334585244-10249-2-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 drivers/pinctrl/pinconf.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinconf.c b/drivers/pinctrl/pinconf.c
index 384dcc1..5d231b3 100644
--- a/drivers/pinctrl/pinconf.c
+++ b/drivers/pinctrl/pinconf.c
@@ -455,7 +455,7 @@ static int pinconf_pins_show(struct seq_file *s, void *what)
 		return 0;
 
 	seq_puts(s, "Pin config settings per pin\n");
-	seq_puts(s, "Format: pin (name): pinmux setting array\n");
+	seq_puts(s, "Format: pin (name): configs\n");
 
 	mutex_lock(&pinctrl_mutex);
 
@@ -506,7 +506,7 @@ static int pinconf_groups_show(struct seq_file *s, void *what)
 		return 0;
 
 	seq_puts(s, "Pin config settings per pin group\n");
-	seq_puts(s, "Format: group (name): pinmux setting array\n");
+	seq_puts(s, "Format: group (name): configs\n");
 
 	mutex_lock(&pinctrl_mutex);
 
-- 
1.7.0.4
