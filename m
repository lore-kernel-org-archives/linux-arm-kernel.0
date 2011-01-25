From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 25 Jan 2011 17:10:37 +0530
Subject: [PATCH 3/5] ARM: twd: Add context save restore support
In-Reply-To: <20110125112946.GA13300@n2100.arm.linux.org.uk>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
	<1295859080-15259-4-git-send-email-santosh.shilimkar@ti.com>
	<20110124110609.GJ16202@n2100.arm.linux.org.uk>
	<20110124111114.GA19409@n2100.arm.linux.org.uk>
	<AANLkTikLDamkp9TgnWRESyx4=698D4NXP=W_M9=abfax@mail.gmail.com>
	<20110125112946.GA13300@n2100.arm.linux.org.uk>
Message-ID: <b4c0d6db681c3fcfaf5d6f39d1022bb7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Tuesday, January 25, 2011 5:00 PM
> To: Colin Cross
> Cc: Santosh Shilimkar; catalin.marinas at arm.com;
> linus.ml.walleij at gmail.com; linux-omap at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH 3/5] ARM: twd: Add context save restore support
>
> On Mon, Jan 24, 2011 at 11:39:13PM -0800, Colin Cross wrote:
> > This doesn't work for oneshot timers if the TWD_TIMER_CONTROL
> register
> > gets reset by cpu idle between twd_set_mode and
> twd_set_next_event.
> > Shadowing ctrl in a percpu variable and rewriting it during every
> call
> > to twd_set_next_event does work, but that's not much different,
> and a
> > little less efficient, than just saving and restoring the control
> and
> > load registers in idle.  It does have the advantage that platforms
> > don't need any extra calls.
>
> BTW, do you think the patch is, nevertheless, an improvement and
> something
> we should do?  If so, please can I have your ack for it?
>
As I was suspecting the one shot mode wouldn't work it. Collin
just confirmed it.
To make it fully work it needs control register save restore.
And that can be managed within TWD library so that every platform
doesn't have to bother of calling it from their idle code.

Do you prefer that as a separate patch or I can post a new version
in which can add your fix + per cpu control register shadowing ?

Regards,
Santosh
