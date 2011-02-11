From: mroberto@cpti.cetuc.puc-rio.br (Marcelo Roberto Jimenez)
Date: Fri, 11 Feb 2011 11:50:24 -0200
Subject: [PATCH] RTC: Include information about UIE and PIE in RTC driver proc.
In-Reply-To: <1297432224-14001-1-git-send-email-mroberto@cpti.cetuc.puc-rio.br>
References: <1297432224-14001-1-git-send-email-mroberto@cpti.cetuc.puc-rio.br>
Message-ID: <1297432224-14001-2-git-send-email-mroberto@cpti.cetuc.puc-rio.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Generic RTC code is always able to provide the necessary information
about update and periodic interrupts. This patch add such information to
the proc interface.

Signed-off-by: Marcelo Roberto Jimenez <mroberto@cpti.cetuc.puc-rio.br>
---
 drivers/rtc/rtc-proc.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/rtc/rtc-proc.c b/drivers/rtc/rtc-proc.c
index c086fc3..a61091c 100644
--- a/drivers/rtc/rtc-proc.c
+++ b/drivers/rtc/rtc-proc.c
@@ -69,6 +69,14 @@ static int rtc_proc_show(struct seq_file *seq, void *offset)
 				alrm.enabled ? "yes" : "no");
 		seq_printf(seq, "alrm_pending\t: %s\n",
 				alrm.pending ? "yes" : "no");
+		seq_printf(seq, "update IRQ enabled\t: %s\n",
+			(rtc->uie_rtctimer.enabled) ? "yes" : "no");
+		seq_printf(seq, "periodic IRQ enabled\t: %s\n",
+			(rtc->pie_enabled) ? "yes" : "no");
+		seq_printf(seq, "periodic IRQ frequency\t: %d\n",
+			rtc->irq_freq);
+		seq_printf(seq, "max user IRQ frequency\t: %d\n",
+			rtc->max_user_freq);
 	}
 
 	seq_printf(seq, "24hr\t\t: yes\n");
-- 
1.7.3.4
