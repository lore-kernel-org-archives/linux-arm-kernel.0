From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 31 Mar 2015 17:14:02 +0300
Subject: [PATCH 01/11] clocksource: arm_arch_timer: Rename
 arch_timer_probed to reflect behaviour
In-Reply-To: <20150331071452.GA9252@gmail.com>
References: <5519AEB2.8050306@linaro.org>
 <1427746633-9137-1-git-send-email-daniel.lezcano@linaro.org>
 <20150331071452.GA9252@gmail.com>
Message-ID: <15031814.pvNHsWnCPH@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ingo,

On Tuesday 31 March 2015 09:14:52 Ingo Molnar wrote:
> * Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> > From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > 
> > The arch_timer_probed function returns whether the given time doesn't
> > need to be probed. This can be the case when the timer has been probed
> > already, but also when it has no corresponding enabled node in DT.
> > 
> > Rename the function to arch_timer_need_probe and invert its return value
> > to better reflect the function's purpose and behaviour.
> > 
> > Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---
> > 
> >  drivers/clocksource/arm_arch_timer.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/clocksource/arm_arch_timer.c
> > b/drivers/clocksource/arm_arch_timer.c index a3025e7..50bb7f2 100644
> > --- a/drivers/clocksource/arm_arch_timer.c
> > +++ b/drivers/clocksource/arm_arch_timer.c
> > @@ -661,17 +661,17 @@ static const struct of_device_id
> > arch_timer_mem_of_match[] __initconst = {> 
> >  };
> >  
> >  static bool __init
> > 
> > -arch_timer_probed(int type, const struct of_device_id *matches)
> > +arch_timer_need_probe(int type, const struct of_device_id *matches)
> 
> If we do a rename we might as well use valid English spelling such as
> 'arch_timer_needs_probing()'?

Of course. Should I resend the patch or can you fix that while applying it ?

-- 
Regards,

Laurent Pinchart
