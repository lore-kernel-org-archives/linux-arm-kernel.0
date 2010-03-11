From: mroberto@cpti.cetuc.puc-rio.br (Marcelo Roberto Jimenez)
Date: Thu, 11 Mar 2010 17:10:23 -0300
Subject: [PATCH 2/4] ARM: mach-sa1100: Print the value of RTSR on
	/proc/drivers/rtc.
In-Reply-To: <1268338225-32253-1-git-send-email-mroberto@cpti.cetuc.puc-rio.br>
References: <1268338225-32253-1-git-send-email-mroberto@cpti.cetuc.puc-rio.br>
Message-ID: <1268338225-32253-2-git-send-email-mroberto@cpti.cetuc.puc-rio.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a line to the output of /proc/drivers/rtc to show
the value of the RTSR register. It will be used to demonstrate
a nasty initialization bug that will be fixed in the sequence.

Signed-off-by: Marcelo Roberto Jimenez <mroberto@cpti.cetuc.puc-rio.br>
---
 drivers/rtc/rtc-sa1100.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
index e19ed0f..b04c837 100644
--- a/drivers/rtc/rtc-sa1100.c
+++ b/drivers/rtc/rtc-sa1100.c
@@ -334,6 +334,7 @@ static int sa1100_rtc_proc(struct device *dev, struct seq_file *seq)
 	seq_printf(seq, "periodic_IRQ\t: %s\n",
 			(OIER & OIER_E1) ? "yes" : "no");
 	seq_printf(seq, "periodic_freq\t: %ld\n", rtc_freq);
+	seq_printf(seq, "RTSR\t\t: 0x%08x\n", (u32)RTSR);
 
 	return 0;
 }
-- 
1.7.0.1
