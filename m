From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Wed, 24 Aug 2011 00:13:40 +0200
Subject: try_to_freeze() called with IRQs disabled on ARM
In-Reply-To: <CAOS58YNUSn2eVLDLzqKmrtL7M5tSetkhZ1ODecLK54NSDnZVAA@mail.gmail.com>
References: <20110823151936.GM9232@opensource.wolfsonmicro.com>
	<201108232351.55432.rjw@sisk.pl>
	<CAOS58YNUSn2eVLDLzqKmrtL7M5tSetkhZ1ODecLK54NSDnZVAA@mail.gmail.com>
Message-ID: <201108240013.40705.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, August 23, 2011, Tejun Heo wrote:
> Hello,
> 
> On Tue, Aug 23, 2011 at 11:51 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> and the boot runs very slowly.  Reverting the series merged in 56f0be
> >> appears to resolve the issue,
> >
> > In fact, the patch from:
> >
> > https://patchwork.kernel.org/patch/1083602/
> >
> > is sufficient to make the calltrace go away.
> 
> Yes, that's true but the added might_sleep() discovered an actual bug
> here, so I still think it's better to keep it there.

Well, I think we _have_ _to_ put it into __refrigerator() at least until
the ARM issue is fixed (other architectures seem to do similar things, BTW),
since otherwise this can be reported over and over again.

Let's try to fix the known issues first and _then_ we can move the
might_sleep() back into try_to_freeze().

Thanks,
Rafael
