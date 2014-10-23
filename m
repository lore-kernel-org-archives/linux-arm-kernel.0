From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 24 Oct 2014 02:29:16 +0300
Subject: [PATCH] clocksource: arm_arch_timer: Don't wait for probe of
 unexisting timers
In-Reply-To: <20141023174911.GA20121@leverpostej>
References: <1414085558-2148-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <54493D46.6040202@codeaurora.org> <20141023174911.GA20121@leverpostej>
Message-ID: <2242736.dh2oR22Axq@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thursday 23 October 2014 18:49:11 Mark Rutland wrote:
> On Thu, Oct 23, 2014 at 06:39:18PM +0100, Stephen Boyd wrote:
> > On 10/23/2014 10:32 AM, Laurent Pinchart wrote:
> > > Commit c387f07e6205 ("clocksource: arm_arch_timer: Discard unavailable
> > > timers correctly") attempted to avoid waiting for probe of disabled
> > > timers, but got its condition check wrong and resulted in the driver
> > > waiting for probe of timers not present in DT at all. Fix it.
> > > 
> > > Fixes: c387f07e6205 ("clocksource: arm_arch_timer: Discard unavailable
> > > timers correctly") Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com> ---
> > 
> > You're the third one. I like how the function has been renamed in this
> > patch. arch_timer_probed() is not accurately describing the intention of
> > the code so arch_timer_need_probe() reads better. Maybe your rename of
> > the function can be squashed into Marc's patch.
> 
> I'm happy with that as a cleanup, but right now I'd just like to see
> Marc's patch hit mainline as-is. It's days old and tested, and it would
> be nice to avoid another potential bug (not that I believe this patch is
> in any way broken).

Sure. I'll resend my patch as a cleanup on top of Marc's fix.

-- 
Regards,

Laurent Pinchart
