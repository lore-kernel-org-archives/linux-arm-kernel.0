From: gregkh@linuxfoundation.org (gregkh at linuxfoundation.org)
Date: Wed, 22 Aug 2018 09:37:23 +0200
Subject: Patch "clocksource/drivers/stm32: Fix error return code" has been
 added to the 4.17-stable tree
Message-ID: <153492344324191@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This is a note to let you know that I've just added the patch titled

    clocksource/drivers/stm32: Fix error return code

to the 4.17-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     clocksource-drivers-stm32-fix-error-return-code.patch
and it can be found in the queue-4.17 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From foo at baz Wed Aug 22 09:16:55 CEST 2018
From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sun, 10 Jun 2018 16:24:15 +0200
Subject: clocksource/drivers/stm32: Fix error return code

From: Julia Lawall <Julia.Lawall@lip6.fr>

[ Upstream commit a26ed66c20f080c510fcf5bd448bce204f2c19d7 ]

Return an error code on failure.

Problem found using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: kernel-janitors at vger.kernel.org
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: linux-arm-kernel at lists.infradead.org
Link: https://lkml.kernel.org/r1528640655-18948-3-git-send-email-Julia.Lawall at lip6.fr
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clocksource/timer-stm32.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -304,8 +304,10 @@ static int __init stm32_timer_init(struc
 
 	to->private_data = kzalloc(sizeof(struct stm32_timer_private),
 				   GFP_KERNEL);
-	if (!to->private_data)
+	if (!to->private_data) {
+		ret = -ENOMEM;
 		goto deinit;
+	}
 
 	rstc = of_reset_control_get(node, NULL);
 	if (!IS_ERR(rstc)) {


Patches currently in stable-queue which might be from Julia.Lawall at lip6.fr are

queue-4.17/clocksource-drivers-stm32-fix-error-return-code.patch
