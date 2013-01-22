From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 22 Jan 2013 11:04:56 +0000
Subject: [PATCH] ARM: architected timers: allow dt based discovery
 using clocksource_of_init
In-Reply-To: <CAJuYYwSfH8jTterd6aNc_Aw81PBschfCUf=REKB35=Y4a=i_7A@mail.gmail.com>
References: <1358731326-2979-1-git-send-email-thomas.abraham@linaro.org>
 <50FD7904.1070201@wwwdotorg.org>
 <CAJuYYwSfH8jTterd6aNc_Aw81PBschfCUf=REKB35=Y4a=i_7A@mail.gmail.com>
Message-ID: <20130122110456.GC18876@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 06:30:47PM +0000, Thomas Abraham wrote:
> Hi Stephen,
> 
> On 21 January 2013 09:21, Stephen Warren <swarren@wwwdotorg.org> wrote:
> > On 01/20/2013 06:22 PM, Thomas Abraham wrote:
> >> Add an entry in __clksrc_of_table so that ARMv7 architected timer is
> >> discoverable using call to clocksource_of_init.
> >
> >> diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
> >
> >> +#ifdef CONFIG_CLKSRC_OF
> >> +CLOCKSOURCE_OF_DECLARE(armv7_timer, "arm,armv7-timer", arch_timer_of_register)
> >> +#endif
> >
> > I wonder if we shouldn't enhance include/linux/clocksource.h to define
> > CLOCKSOURCE_OF_DECLARE even when !CONFIG_CLKSRC_OF; that way, drivers
> > wouldn't need that ifdef.
> 
> Yes, it will be helpful to have a !CONFIG_CLKSRC_OF version of
> CLOCKSOURCE_OF_DECLARE. And can CONFIG_CLKSRC_OF be enabled by default
> for all ARM platforms?
> 
> Thanks,
> Thomas.

Thomas,

Once the above is worked out, could you send me the updated patch with a
pointer to whichever {branch,patch}(es) I need for CLKSRC_OF?

Thanks,
Mark.
