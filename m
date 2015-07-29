From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Wed, 29 Jul 2015 01:50:25 +0000
Subject: [PATCH 1/2] drivers: watchdog: at91sam9_wdt: add new feature
 support
In-Reply-To: <55B82AE1.2050906@roeck-us.net>
References: <1438066825-21923-1-git-send-email-wenyou.yang@atmel.com>
 <1438066825-21923-2-git-send-email-wenyou.yang@atmel.com>
 <55B72BC0.8070206@roeck-us.net>
 <B256D81BAE5131468A838E5D7A243641C9F820CB@penmbx01>
 <55B82AE1.2050906@roeck-us.net>
Message-ID: <B256D81BAE5131468A838E5D7A243641C9F82110@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

Thank you for your prompt answer.

> -----Original Message-----
> From: Guenter Roeck [mailto:linux at roeck-us.net]
> Sent: 2015?7?29? 9:23
> To: Yang, Wenyou; wim at iguana.be; robh+dt at kernel.org; pawel.moll at arm.com;
> mark.rutland at arm.com; ijc+devicetree at hellion.org.uk; galak at codeaurora.org
> Cc: sylvain.rochet at finsecur.com; Ferre, Nicolas; boris.brezillon at free-
> electrons.com; devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-
> watchdog at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 1/2] drivers: watchdog: at91sam9_wdt: add new feature
> support
> 
> On 07/28/2015 05:38 PM, Yang, Wenyou wrote:
> > Hi Guenter,
> >
> > Thank you very much for your review.
> >
> >> -----Original Message-----
> >> From: Guenter Roeck [mailto:linux at roeck-us.net]
> >> Sent: 2015?7?28? 15:14
> >> To: Yang, Wenyou; wim at iguana.be; robh+dt at kernel.org;
> >> pawel.moll at arm.com; mark.rutland at arm.com;
> >> ijc+devicetree at hellion.org.uk; galak at codeaurora.org
> >> Cc: sylvain.rochet at finsecur.com; Ferre, Nicolas;
> >> boris.brezillon at free- electrons.com; devicetree at vger.kernel.org;
> >> linux-kernel at vger.kernel.org; linux- watchdog at vger.kernel.org;
> >> linux-arm-kernel at lists.infradead.org
> >> Subject: Re: [PATCH 1/2] drivers: watchdog: at91sam9_wdt: add new
> >> feature support
> >>
> >> On 07/28/2015 12:00 AM, Wenyou Yang wrote:
> >>> In the datasheet, the new feature is describled as "WDT_MR can be
> >>> written until a LOCKMR command is issued in WDT_CR".
> >>> That is to say, as long as the bootstrap and u-boot don't issue a
> >>> LOCKMR command, WDT_MR can be written in kernel.
> >>>
> >>> So the driver can enable/disable the watchdog timer hardware, set
> >>> WDV(Watchdog Counter Value) and WDD(Watchdog Delta Value) fields of
> >>> WDT_MR register to set the watchdog timer timeout.
> >>>
> >>> The timer is not necessary that regularly sends a keepalive ping to
> >>> the watchdog timer hardware.
> >>>
> >>> It is introduced from sama5d4 SoCs.
> >>>
> >> Since there are so many changes, I wonder is a separate driver would
> >> make more sense.
> > Yes, a bit many changes.
> > I thought reuse the driver code.
> > If a separate driver, I am afraid it includes much duplicated code.
> > After all, it is for the same device with different feature.
> >
> > I don't think it is necessary to have multiple drivers for the same peripheral with
> different feature.
> >
> 
> The concept for the two mechanisms is all different: In one, the watchdog
> keepalive is triggered from timer code. In the other, the watchdog timeout is
> triggered directly from the heartbeat function. One assumes that the watchdog is
> always running, and that it must be pinged even if closed. The other disables the
> watchdog on close.
> 
> What I _can_ see is that the driver is becoming an unmaintainable mess, with lots
> of if/else in pretty much every function. I consider this much less desirable than a
> bit of code duplication - if there is any. Seriously, most of the added code might as
> well be for a completely different chip.

You are right, I accepted your advice. I will rewrite it. Thanks.

> 
> Guenter

Best Regards,
Wenyou Yang
