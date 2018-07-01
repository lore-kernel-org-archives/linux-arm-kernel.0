From: gregkh@linuxfoundation.org (gregkh at linuxfoundation.org)
Date: Sun, 01 Jul 2018 11:01:02 +0200
Subject: Patch "thermal: bcm2835: Stop using printk format %pCr" has been
 added to the 4.14-stable tree
Message-ID: <15304356623499@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This is a note to let you know that I've just added the patch titled

    thermal: bcm2835: Stop using printk format %pCr

to the 4.14-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     thermal-bcm2835-stop-using-printk-format-pcr.patch
and it can be found in the queue-4.14 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From bd2a07f71a1e2e198f8a30cb551d9defe422d83d Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 1 Jun 2018 11:28:20 +0200
Subject: thermal: bcm2835: Stop using printk format %pCr

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit bd2a07f71a1e2e198f8a30cb551d9defe422d83d upstream.

Printk format "%pCr" will be removed soon, as clk_get_rate() must not be
called in atomic context.

Replace it by printing the variable that already holds the clock rate.
Note that calling clk_get_rate() is safe here, as the code runs in task
context.

Link: http://lkml.kernel.org/r/1527845302-12159-3-git-send-email-geert+renesas at glider.be
To: Jia-Ju Bai <baijiaju1990@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
To: Michael Turquette <mturquette@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>
To: Zhang Rui <rui.zhang@intel.com>
To: Eduardo Valentin <edubezval@gmail.com>
To: Eric Anholt <eric@anholt.net>
To: Stefan Wahren <stefan.wahren@i2se.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-doc at vger.kernel.org
Cc: linux-clk at vger.kernel.org
Cc: linux-pm at vger.kernel.org
Cc: linux-serial at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-renesas-soc at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: stable at vger.kernel.org # 4.12+
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/thermal/broadcom/bcm2835_thermal.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -213,8 +213,8 @@ static int bcm2835_thermal_probe(struct
 	rate = clk_get_rate(data->clk);
 	if ((rate < 1920000) || (rate > 5000000))
 		dev_warn(&pdev->dev,
-			 "Clock %pCn running at %pCr Hz is outside of the recommended range: 1.92 to 5MHz\n",
-			 data->clk, data->clk);
+			 "Clock %pCn running at %lu Hz is outside of the recommended range: 1.92 to 5MHz\n",
+			 data->clk, rate);
 
 	/* register of thermal sensor and get info from DT */
 	tz = thermal_zone_of_sensor_register(&pdev->dev, 0, data,


Patches currently in stable-queue which might be from geert+renesas at glider.be are

queue-4.14/lib-vsprintf-remove-atomic-unsafe-support-for-pcr.patch
queue-4.14/thermal-bcm2835-stop-using-printk-format-pcr.patch
queue-4.14/serial-sh-sci-use-spin_-try-lock_irqsave-instead-of-open-coding-version.patch
queue-4.14/clk-renesas-cpg-mssr-stop-using-printk-format-pcr.patch
