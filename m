From: cminyard@mvista.com (Corey Minyard)
Date: Thu, 17 Apr 2014 12:15:11 -0500
Subject: kgdb on ARM printing a bogus OOPs
Message-ID: <53500C1F.3040505@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I was playing with kgdb on ARM, and I noticed that every time it hits a
breakpoint I get the following:

  Internal error: Oops - undefined instruction: 0 [#3] PREEMPT SMP ARM

It's mostly harmless, the breakpoints still work, but all the printks
could be troublesome in some debugging situations.  It's there because
the notify_die() call was added after the printk in question.  I'd guess
it should be before the printk, but is there a reason it was added after?

Thanks,

-corey
