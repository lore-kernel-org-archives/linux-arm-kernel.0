From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 May 2012 11:05:36 -0700
Subject: [PATCH-V2] ARM: OMAP2+: am33xx: Make am33xx as a separate class
In-Reply-To: <20120510180159.GF21851@atomide.com>
References: <1336562667-6741-1-git-send-email-hvaibhav@ti.com>
 <20120509185435.GU5088@atomide.com>
 <20120510180159.GF21851@atomide.com>
Message-ID: <20120510180535.GG21851@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120510 11:06]:
> * Tony Lindgren <tony@atomide.com> [120509 11:58]:
> > * Vaibhav Hiremath <hvaibhav@ti.com> [120509 04:28]:
> > > Initially, we decided to make am33xx family of device to fall
> > > under omap3 class (cpu_is_omap34xx() = true), since it carries
> > > Cortex-A8 core. But while adding complete baseport support
> > > (like, clock, power and hwmod) support, it is observed that,
> > > we are creating more and more problems by treating am33xx device
> > > as omap3 family, as nothing matches between them
> > > (except cortex-A8 mpu).
> > 
> > Thanks applying into devel-soc after updating for soc_is change
> > and fixing typo in the description that stil said OMAPAM. Updated
> > patch below.
> 
> Turns out we still need to add defined(CONFIG_SOC_AM33XX) around
> __omap2_set_globals() to keep compile working when omap4 + am33xx
> are selected without omap2 or 3. Also removed the "default y"
> for am33xx as that's where we're heading to anyways.
> 
> Updated patch below.

Argh, now it breaks with:

arch/arm/mach-omap2/built-in.o: In function `omap2_set_globals_am33xx':
twl-common.c:(.init.text+0x1dd8): undefined reference to `omap2_set_globals_sdrc'

There are clearly some dependencies to the clean up patches being
discussed.. So I'll drop this for now until the clean up is sorted
out.

Regards,

Tony
