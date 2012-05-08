From: tony@atomide.com (Tony Lindgren)
Date: Tue, 8 May 2012 14:58:16 -0700
Subject: [PATCH] ARM: OMAP2+: am33xx: Make am33xx as a separate class
In-Reply-To: <87ipg6l4jp.fsf@ti.com>
References: <1336490630-7272-1-git-send-email-hvaibhav@ti.com>
 <87ipg6l4jp.fsf@ti.com>
Message-ID: <20120508215816.GJ5088@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [120508 15:00]:
> Vaibhav Hiremath <hvaibhav@ti.com> writes:
> 
> > Initially, we decided to make am33xx family of device to fall
> > under omap3 class (cpu_is_omap34xx() = true), since it carries
> > Cortex-A8 core. But while adding complete baseport support
> > (like, clock, power and hwmod) support, it is observed that,
> > we are creating more and more problems by treating am33xx device
> > as omap3 family, as nothing matches between them
> > (except cortex-A8 mpu).
> >
> > So,  after long discussion we have came to the conclusion that,
> > we should not consider am33xx device as omap3 family, instead
> > create separate class (SOC_OMAPAM33XX) under OMAP2PLUS.
> > This means, for am33xx device, cpu_is_omap34xx() will return false,
> > and only cpu_is_am33xx() will be true.
> 
> Not directly related to this patch, but does anyone have any objection
> to dropping the OMAP from the SOC_ names for AM33xx and TI81XX?
> 
> I'll post a series shortly to do so.

No objection.

Tony
