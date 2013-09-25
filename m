From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 25 Sep 2013 08:37:19 -0700
Subject: [PATCH v2 0/4] arm: zynq: Enable global timer
In-Reply-To: <5242FF4B.6050901@linaro.org>
References: <1379530118-22813-1-git-send-email-soren.brinkmann@xilinx.com>
 <5242FF4B.6050901@linaro.org>
Message-ID: <06680eeb-11e3-4fdc-99f7-1b57c06deb11@CO1EHSMHS021.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 25, 2013 at 05:20:43PM +0200, Daniel Lezcano wrote:
> On 09/18/2013 08:48 PM, Soren Brinkmann wrote:
> > Hi all,
> > 
> > here's a v2. I reused the subject from my v1 submission although the focus of
> > this series moved a bit towards the timer subsystem.
> > I replaced Stephen's fix to prevent per cpu devices from becoming
> > the broadcast device with Thomas' proposal, but I kept the original commit
> > message. I split the whole approach in small chunks that I found reasonable.
> > 
> > In 4/4, I picked up Grant's comment regarding the DT node name.
> > 
> > v2:
> >  - drop 1/2 of the original series
> >  - implement preventing per cpu devices from becoming broadcast device according
> >    to Thomas' proposal
> >    - introduce new CLOCK_EVT_FEAT_PERCPU flag
> >    - set the flag for the arm_global_timer
> >    - filter per cpu devices based on this flag when choosing the broadcast
> >      device
> >  - rename DT node to avoid '_'s
> >  
> > 
> > Soren Brinkmann (4):
> >   clockchips: Add FEAT_PERCPU clockevent flag
> >   clocksource/arm_global_timer: Set FEAT_PERCPU flag
> >   tick: broadcast: Deny per-cpu clockevents from being broadcast sources
> >   arm: zynq: Enable arm_global_timer
> > 
> >  arch/arm/boot/dts/zynq-7000.dtsi       | 8 ++++++++
> >  arch/arm/mach-zynq/Kconfig             | 1 +
> >  drivers/clocksource/arm_global_timer.c | 3 ++-
> >  include/linux/clockchips.h             | 1 +
> >  kernel/time/tick-broadcast.c           | 1 +
> >  5 files changed, 13 insertions(+), 1 deletion(-)
> 
> This patches falls under different maintainer's umbrella.
> 
> I acked-by the patches, so if someone is willing to take the patches I
> am ok with that. I am ok also to pick them into my tree with the
> acked-by maintainer. Just let me know ...

Thanks Daniel. I agree you/timer folks and Michal/armsoc have to figure
out how to resolve this the easiest way. I'd almost say merging this all
through the timers tree might be the easiest. The conflict which might
occur in the Zynq dts file should be trivial since the patch is purely
additive.

But well, up to you.

	S?ren
