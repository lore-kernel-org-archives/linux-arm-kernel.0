From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 30 May 2011 09:25:42 +0100
Subject: [RFC PATCH v4 11/13] ARM: gic: remove previous local timer
	interrupt handling
In-Reply-To: <20110530090805.73937acd@taxman.wild-wind.fr.eu.org>
References: <1306513671-12206-1-git-send-email-marc.zyngier@arm.com>
	<1306513671-12206-12-git-send-email-marc.zyngier@arm.com>
	<4DDFFBCE.8020908@codeaurora.org>
	<20110530090805.73937acd@taxman.wild-wind.fr.eu.org>
Message-ID: <20110530092542.3ab5ad6a@taxman.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 May 2011 09:08:05 +0100
Marc Zyngier <marc.zyngier@arm.com> wrote:

> On Fri, 27 May 2011 12:30:22 -0700
> Stephen Boyd <sboyd@codeaurora.org> wrote:
> 
> > On 05/27/2011 09:27 AM, Marc Zyngier wrote:
> > > Now that all users of local timers are using CONFIG_ARM_GIC_VPPI,
> > > the now unused local timer infrastructure can be safely removed.
> > >
> > > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > > ---
> > >
> > 
> > Can you also remove local_timer_ack() from MSM in this patch? If you do,
> > feel free to add an
> > 
> > Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> > 
> > to this patch.
> 
> This patch breaks the kernel link when building for SMP.
> I'll add a weak version of local_timer_ack() for the time being.

Actually, this is worse. Having a weak version of local_timer_ack() in
smp.c clashes badly with this symbol being a #define with TWD is
selected...

Let's drop that bit for now, and I'll address it in the timer series.

	M.
-- 
I'm the slime oozin' out from your TV set...
