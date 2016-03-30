From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 22:03:43 +0200
Subject: [PATCH v5 20/46] pwm: add information about polarity,
 duty cycle and period to debugfs
In-Reply-To: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459368249-13241-21-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Heiko St?bner <heiko@sntech.de>

The pwm-states make it possible to also output the polarity, duty cycle
and period information in the debugfs pwm summary-outout.
This makes it easier to gather overview information about pwms without
needing to walk through the sysfs attributes of every pwm.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index c2b1569..9a83840 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -894,6 +894,11 @@ static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
 		if (pstate.enabled)
 			seq_puts(s, " enabled");
 
+		seq_printf(s, " period:%uns", pstate.period);
+		seq_printf(s, " duty:%uns", pstate.duty_cycle);
+		seq_printf(s, " polarity:%s",
+			   pstate.polarity ? "inverse" : "normal");
+
 		seq_puts(s, "\n");
 	}
 }
-- 
2.5.0
