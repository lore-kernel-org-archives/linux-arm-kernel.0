From: vzapolskiy@gmail.com (Vladimir Zapolskiy)
Date: Wed, 17 Mar 2010 13:57:57 +0300
Subject: [PATCH 2/2] [ARM] [IMX]: Fix clock usecount counter from
	underflow.
In-Reply-To: <eedb5541003170315t55f3aff1n4dadd25d08a35d7b@mail.gmail.com>
References: <1268809916-6525-1-git-send-email-vzapolskiy@gmail.com>
	<1268809916-6525-2-git-send-email-vzapolskiy@gmail.com>
	<20100317092042.GB16150@pengutronix.de>
	<eedb5541003170315t55f3aff1n4dadd25d08a35d7b@mail.gmail.com>
Message-ID: <acc484891003170357t151171e7of57a459cc46e9c4e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

and thank you for helpful comments.

2010/3/17 javier Martin <javier.martin@vista-silicon.com>

> 2010/3/17 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > I'm not sure this is worth it.  IMHO an unbalanced clk_disable is a
> > severe bug that doesn't need to be handled smoothly.
> >
> > But maybe move the WARN_ON before the __clk_disable(clk->parent)?  This
> > way the disabled parent clock cannot stop the message to appear.
> >
> > Other than that, please use WARN instead of printk + WARN_ON.  Then the
> > message is printed only after the oops begin marker.
>
> I agree with Uwe, I myself tried to do something similar in the past and
> people
> made me realize that we don't have to fix here what is really a problem in
> some
> driver which calls unbalanced disable/enable.
>
> However, I think using WARN would be a good idea since it allows the
> kernel hacker
> to track an error which according to my own experience is very
> difficult to detect.
>
>
I agree with all of you that this patch is not a bug fix, but definitely a
misfeature elimination.

WARN must be present anyway to inform about an incident of multiple
clk_disable() calls, no doubt. But I assume that if a board can be easily
left in working condition after all, this could help the kernel hacker too.

Let me send a patch with respect to Uwe's comments firstly.

With best wishes,
Vladimir
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100317/96ceefa3/attachment-0001.htm>
