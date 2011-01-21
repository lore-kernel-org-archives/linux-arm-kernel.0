From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Jan 2011 10:27:07 +0000
Subject: [PATCH] ARM: mxs: irq_data conversion
In-Reply-To: <20110121101536.GH14956@pengutronix.de>
References: <1295600518-11300-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110121094338.GE13235@n2100.arm.linux.org.uk>
	<20110121101536.GH14956@pengutronix.de>
Message-ID: <20110121102707.GH13235@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 21, 2011 at 11:15:36AM +0100, Uwe Kleine-K?nig wrote:
> IMHO doing it the other way round would be better.  (i.e. use a def_bool
> y for the unconverted platforms and then push that down.)  But maybe
> this is just a matter of taste.
> 
> How should we proceed?  Lennert, do you take my patch?  Should I resend
> without the select?  IIRC there were send a few other patches (for tegra
> maybe?).  Don't know if you missed these, too?

It looks like it's relatively few platforms which were missed:

arch/arm/mach-msm/gpio-v2.c-    .mask           = msm_gpio_irq_mask,
arch/arm/mach-msm/gpio-v2.c-    .unmask         = msm_gpio_irq_unmask,
arch/arm/mach-msm/gpio-v2.c-    .ack            = msm_gpio_irq_ack,
arch/arm/mach-lh7a40x/irq-kev7a400.c-   .ack    = lh7a400_ack_cpld_irq,
arch/arm/mach-lh7a40x/irq-kev7a400.c-   .mask   = lh7a400_mask_cpld_irq,
arch/arm/mach-lh7a40x/irq-kev7a400.c-   .unmask = lh7a400_unmask_cpld_irq,
arch/arm/mach-vt8500/irq.c-     .ack       = vt8500_irq_mask,
arch/arm/mach-vt8500/irq.c-     .mask      = vt8500_irq_mask,
arch/arm/mach-vt8500/irq.c-     .unmask    = vt8500_irq_unmask,
arch/arm/mach-mxs/gpio.c-       .ack = mxs_gpio_ack_irq,
arch/arm/mach-mxs/gpio.c-       .mask = mxs_gpio_mask_irq,
arch/arm/mach-mxs/gpio.c-       .unmask = mxs_gpio_unmask_irq,
arch/arm/mach-mxs/icoll.c-      .ack = icoll_ack_irq,
arch/arm/mach-mxs/icoll.c-      .mask = icoll_mask_irq,
arch/arm/mach-mxs/icoll.c-      .unmask = icoll_unmask_irq,

vt8500 is new in my tree, so needs to be updated.  The other stuff I
guessed Lennert missed for one reason or another, so... patches welcome.
