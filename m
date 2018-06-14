From: gregkh@linuxfoundation.org (gregkh at linuxfoundation.org)
Date: Thu, 14 Jun 2018 11:49:51 +0200
Subject: Patch "serial: sh-sci: Stop using printk format %pCr" has been added
 to the 4.16-stable tree
Message-ID: <152896979196201@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This is a note to let you know that I've just added the patch titled

    serial: sh-sci: Stop using printk format %pCr

to the 4.16-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     serial-sh-sci-stop-using-printk-format-pcr.patch
and it can be found in the queue-4.16 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From d63c16f8e1ab761775275adcf54f4bef7c330295 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 1 Jun 2018 11:28:21 +0200
Subject: serial: sh-sci: Stop using printk format %pCr

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit d63c16f8e1ab761775275adcf54f4bef7c330295 upstream.

Printk format "%pCr" will be removed soon, as clk_get_rate() must not be
called in atomic context.

Replace it by open-coding the operation.  This is safe here, as the code
runs in task context.

Link: http://lkml.kernel.org/r/1527845302-12159-4-git-send-email-geert+renesas at glider.be
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
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: stable at vger.kernel.org # 4.5+
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/sh-sci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2691,8 +2691,8 @@ found:
 			dev_dbg(dev, "failed to get %s (%ld)\n", clk_names[i],
 				PTR_ERR(clk));
 		else
-			dev_dbg(dev, "clk %s is %pC rate %pCr\n", clk_names[i],
-				clk, clk);
+			dev_dbg(dev, "clk %s is %pC rate %lu\n", clk_names[i],
+				clk, clk_get_rate(clk));
 		sci_port->clks[i] = IS_ERR(clk) ? NULL : clk;
 	}
 	return 0;


Patches currently in stable-queue which might be from geert+renesas at glider.be are

queue-4.16/serial-sh-sci-stop-using-printk-format-pcr.patch
