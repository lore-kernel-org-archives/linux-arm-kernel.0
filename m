From: tglx@linutronix.de (Thomas Gleixner)
Date: Sun, 5 Jul 2015 23:48:26 +0200 (CEST)
Subject: [PATCH 2/2] at91: use request_irq/free_irq instead of
 setup_irq/remove_irq
In-Reply-To: <1435937609-18623-2-git-send-email-davidcdueck@googlemail.com>
References: <1435937609-18623-1-git-send-email-davidcdueck@googlemail.com>
 <1435937609-18623-2-git-send-email-davidcdueck@googlemail.com>
Message-ID: <alpine.DEB.2.11.1507052341420.3916@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 3 Jul 2015, David Dueck wrote:

> This fixes a warning when using RT-Preempt.

That's not a proper explanation for the patch and by all means it
cannot fix anything because free_irq() is just a different wrapper
around __free_irq() than remove_irq(). So how on earth fixes that the
problem at hand?

Thanks,

	tglx





 
