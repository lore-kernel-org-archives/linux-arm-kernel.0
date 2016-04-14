From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 14 Apr 2016 21:17:44 +0200
Subject: [PATCH v5 24/24] pwm: add information about polarity,
 duty cycle and period to debugfs
In-Reply-To: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1460661464-11216-25-git-send-email-boris.brezillon@free-electrons.com>
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
index aefffcf..9f4e97e 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -959,6 +959,11 @@ static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
 		if (state.enabled)
 			seq_puts(s, " enabled");
 
+		seq_printf(s, " period:%uns", state.period);
+		seq_printf(s, " duty:%uns", state.duty_cycle);
+		seq_printf(s, " polarity:%s",
+			   state.polarity ? "inverse" : "normal");
+
 		seq_puts(s, "\n");
 	}
 }
-- 
2.5.0
