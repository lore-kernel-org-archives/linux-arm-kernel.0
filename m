From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Tue, 29 Mar 2016 15:32:06 +0200
Subject: [PATCH] clockevents/drivers/timer-atmel-pit: fix double free_irq
In-Reply-To: <1458245383-9859-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1458245383-9859-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20160329133206.GA13334@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Alexandre Belloni | 2016-03-17 21:09:43 [+0100]:

>Hi Sebastian,
Hi Alexandre,

>This patch fixes the last warning for preempt-rt on at91. It applies on
>v4.4.4-rt11. Note that the whome PIT/TCB mess will be fixed in another way in
>the mainline as we are reworking the tcb driver to avoid using the pit when
>booting.

oh, okay. I just sent the "arm: at91: do not disable/enable clocks in a
row" patch as you asked me a while ago. It applied cleanly against the
next tree of today.
So I will apply this to get rid of the warning. And if you manage not to
use the PIT during boot then we won't have the free_irq() mess which is
good.

Sebastian
