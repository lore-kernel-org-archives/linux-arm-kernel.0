From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Sun, 20 Nov 2016 11:45:21 +0530
Subject: [PATCH] arm: spin one more cycle in timer-based delays
In-Reply-To: <20161119110301.GQ1041@n2100.armlinux.org.uk>
References: <582B0F61.6030903@free.fr> <20161118120630.GJ13470@arm.com>
 <20161118125409.GK1041@n2100.armlinux.org.uk>
 <582F0DD2.3030805@free.fr> <20161119071702.GA25647@afzalpc>
 <20161119110301.GQ1041@n2100.armlinux.org.uk>
Message-ID: <20161120061521.GA4307@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Sat, Nov 19, 2016 at 11:03:01AM +0000, Russell King - ARM Linux wrote:

> > > 6c5e9059692567740a4ee51530dffe51a4b9584d
> > > https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?h=timers/core&id=6c5e9059692567740a4ee51530dffe51a4b9584d
> > 
> > But the above "timers: Fix usleep_range() in the context of
> > wake_up_process()" is to avoid wakeup causing premature return than
> > about being precise, no ?

> usleep*() is based on the scheduler, which has tighter requirements
> laid down in POSIX amongst other standards, such as "not timing out
> before this specified time"

Thanks for educating on the POSIX linkage.

When the above mentioned patch was flying, tglx initially mentioned
that there is no gurantee that usleep_range() will never return in less
time than the specified minimum, but later he committed the change to
tip-bot keeping the message saying otherwise. That was confusing, and
me being a wayfarer, didn't have the courage to ask.

Regards
afzal
