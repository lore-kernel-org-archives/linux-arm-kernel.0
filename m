From: will.deacon@arm.com (Will Deacon)
Date: Wed, 3 Oct 2012 10:16:36 +0100
Subject: [RFC PATCH 1/2] ARM: use generic strnlen_user and
 strncpy_from_user functions
In-Reply-To: <20121003060042.GB598@pengutronix.de>
References: <1339169935-31775-1-git-send-email-will.deacon@arm.com>
 <1339169935-31775-2-git-send-email-will.deacon@arm.com>
 <20121002175316.GA598@pengutronix.de>
 <20121002191851.GB20411@mudshark.cambridge.arm.com>
 <20121003060042.GB598@pengutronix.de>
Message-ID: <20121003091636.GC22445@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 03, 2012 at 07:00:42AM +0100, Uwe Kleine-K?nig wrote:
> On Tue, Oct 02, 2012 at 08:18:51PM +0100, Will Deacon wrote:
> > Ok, thanks for the heads-up. I didn't test it with an M-class CPU, but
> > hopefully that's understandable :)
>
> I think so, yes. But I intend to change that, and I heard your coworker
> gets an efm32 :-)

Yep, he'll be in charge of testing for us (!)

> > > > +#define user_addr_max() \
> > > > +	(segment_eq(get_fs(), USER_DS) ? TASK_SIZE : ~0UL)
> > > > +
> > > I think this is the problem as for no-mmu USER_DS == KERNEL_DS. I will
> > > take a look tomorrow.
> > 
> > I can't immediately see why that would cause a problem, so please let me
> > know if you get more information.
> BTW, I once saw the call to sys_mount fail:
> 
> 	sys_mount ->
> 	copy_mount_string ->
> 	strndup_user ->
> 	strnlen_user returns 0 which makes sys_mount fail with -EFAULT.
> 
> but that was not the problem I hit when I bisected (using merges instead
> of rebasing).

Was this also on your M3?

> We have a bank holiday today in Germany, so it's still tomorrow when I
> will look into the problem. So I hope to be able to give more details
> soon.

Ok, have a good day off.

Will
