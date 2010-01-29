From: dwalker@codeaurora.org (Daniel Walker)
Date: Fri, 29 Jan 2010 06:33:54 -0800
Subject: [RFC PATCH 06/12] arm: msm: set L2CR1 to enable prefetch and
	burst on Scorpion.
In-Reply-To: <1264762740.4242.40.camel@pc1117.cambridge.arm.com>
References: <1264719577-5436-7-git-send-email-dwalker@codeaurora.org>
	<1264762740.4242.40.camel@pc1117.cambridge.arm.com>
Message-ID: <1264775634.5109.42.camel@desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-01-29 at 10:59 +0000, Catalin Marinas wrote:
> On Thu, 2010-01-28 at 22:59 +0000, Daniel Walker wrote:
> > @@ -242,6 +243,10 @@ __v7_setup:
> >         mcr     p15, 0, r4, c2, c0, 1           @ load TTB1
> >         mov     r10, #0x1f                      @ domains 0, 1 = manager
> >         mcr     p15, 0, r10, c3, c0, 0          @ load domain access register
> > +#ifdef CONFIG_ARCH_MSM_SCORPION
> > +       mov     r0, #0x77
> > +       mcr     p15, 3, r0, c15, c0, 3          @ set L2CR1
> > +#endif
> 
> I thought we want to move these out of the kernel into the boot loader
> (or boot monitor or bios or whatever it's called).

I left it in cause it still felt like an open question the last time I
submitted it ..

Honestly, I feel like we should keep as much control in Linux as
possible.. Having it in Linux is just one place for it to get screwed
up, vs. having it in many different boot loaders.

Daniel
