From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 25 Jan 2011 19:25:01 +0530
Subject: [PATCH 3/5] ARM: twd: Add context save restore support
In-Reply-To: <20110125133752.GI13300@n2100.arm.linux.org.uk>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
	<1295859080-15259-4-git-send-email-santosh.shilimkar@ti.com>
	<20110124110609.GJ16202@n2100.arm.linux.org.uk>
	<20110124111114.GA19409@n2100.arm.linux.org.uk>
	<AANLkTikLDamkp9TgnWRESyx4=698D4NXP=W_M9=abfax@mail.gmail.com>
	<20110125103231.GD11507@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101251418260.31804@localhost6.localdomain6>
	<20110125133752.GI13300@n2100.arm.linux.org.uk>
Message-ID: <35c687f501c0d8d8a4435f7b98850b16@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Tuesday, January 25, 2011 7:08 PM
> To: Thomas Gleixner
> Cc: Colin Cross; Santosh Shilimkar; catalin.marinas at arm.com;
> linus.ml.walleij at gmail.com; linux-omap at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH 3/5] ARM: twd: Add context save restore support
>
> On Tue, Jan 25, 2011 at 02:23:10PM +0100, Thomas Gleixner wrote:
> > On Tue, 25 Jan 2011, Russell King - ARM Linux wrote:

[...]
> > > The next question is can we teach the generic time
> infrastructure about
> > > this so we don't have to modify every clock event driver for it?
> We
> > > really need to get away from having this kind of knowledge
> buried down
> > > in the lowest levels of every driver.
> >
> > In which way? I mean the generic code issues a call to the
> set_mode
> > function when we leave the broadcast mode. So what should the
> generic
> > code do more ?
>
> I can't say because these patches only add the hooks, there's no
> implementation yet which uses the hooks.
>
> Given the description about _why_ those hooks are necessary, it
> seems
> that something is required.  Either we start adding custom hacks to
> each clockevent driver as is done with this patch, or we get some
> generic help in place.
>
> I'm not thrilled by the custom hack approach - and I thought the
> clockevent stuff was created to stop this kind of thing happening.
>
> I suggest we defer this until there's a visible use case available.
Just for clarification. Without the TWD save restore patch the PM
won't work. So what you mean by visible usecase.
We need this to be fixed and that's what was done with the my
patch. Ofcourse it's a custom hack approach but does the job.

Regards,
Santosh
