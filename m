From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Feb 2012 16:29:58 +0100
Subject: [PATCH] ARM/sp810: introduce API to change system mode
In-Reply-To: <20120227105506.GS22562@n2100.arm.linux.org.uk>
References: <bd90082f199c9bd0e48e0177ced627a50d5f850e.1329988357.git.viresh.kumar@st.com>
 <CACRpkdaG2e12fdCFDUoQ_n71VcqU3ZpkH0raHW+EAZg==JOxrg@mail.gmail.com>
 <20120227105506.GS22562@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdZgVSibWugOXcPU7Ai7zjGJMp0BMuKhjs-h0Y=Xee868g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2012 at 11:55 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Feb 27, 2012 at 11:38:14AM +0100, Linus Walleij wrote:
>> Maybe I'm delusional but I think this could help centralizing the use
>> of the SP* cells, since they're obviously used in both SPEAr and
>> versatile express.
>
> They can be used in any PrimeXsys based system, and I don't see that
> there's anything which guarantees having both a SP810 and SP804
> together.
>
> There are platforms which have SP804 without SP810 - Integrator CP
> and bcmring seem to fall into that category.

I was more thinking the other way around - I think that all systems
with an SP810 also have an SP804.

I'm led to thinking this because of these registers:

#define SCCTRL_TIMEREN0SEL_REFCLK       (0 << 15)
#define SCCTRL_TIMEREN0SEL_TIMCLK       (1 << 15)
#define SCCTRL_TIMEREN1SEL_REFCLK       (0 << 17)
#define SCCTRL_TIMEREN1SEL_TIMCLK       (1 << 17)

TIMER0 and TIMER1 seems to indicate TIMER0 and TIMER1
of the SP804 block.

In any case it seems to depend on CONFIG_ARM_TIMER_SP804.

> But... the register concerned does a whole load of other things, and
> I'm not sure we want to have accesses to it de-centralized.

Sure, just arch/arm/common/sc-810.c works fine as well.

Now I got incentive to finally write that letter to Greg about what
to do with system controllers.

Yours,
Linus Walleij
