From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 8 Jun 2017 15:26:40 +0200
Subject: [PATCH] arm: aspeed: Add clock-names property to timer node
In-Reply-To: <CAK8P3a0v1+FRnXcwF7j45bmDuX5caL9RBcS1bSUwANqb=zxeqQ@mail.gmail.com>
References: <20170605074846.30925-1-andrew@aj.id.au>
 <CACPK8XeM6fBztHwfrPUD+ewpMf==tBqgfj61B-k=SwT3ABTiZw@mail.gmail.com>
 <CAK8P3a2d=T9igbhe1u3MBUF2F1TMLC7z0DQ2AmHX-LkiBAy2Ww@mail.gmail.com>
 <20170607125256.GG2345@mai>
 <CAK8P3a0v1+FRnXcwF7j45bmDuX5caL9RBcS1bSUwANqb=zxeqQ@mail.gmail.com>
Message-ID: <20170608132640.GD2244@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 07, 2017 at 04:29:50PM +0200, Arnd Bergmann wrote:
> On Wed, Jun 7, 2017 at 2:52 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> > On Tue, Jun 06, 2017 at 11:41:11AM +0200, Arnd Bergmann wrote:
> >> On Mon, Jun 5, 2017 at 10:59 AM, Joel Stanley <joel@jms.id.au> wrote:
> >> > On Mon, Jun 5, 2017 at 5:18 PM, Andrew Jeffery <andrew@aj.id.au> wrote:
> >> >> The merging of a number of clocksource drivers into fttmr010 means we
> >> >> require clock-names to be specified in the Aspeed timer node, else the
> >> >> clocksource fails to probe and boot hangs.
> >> >
> >> > Arnd,
> >> >
> >> > Linus' reworked timer driver will go into 4.13.
> >> >
> >> > Can we get this patch merged into 4.12 as a fix so we don't end up
> >> > with a broken boot at any stage?
> >>
> >> Hmm, can't we make the driver backward-compatible and have it fall
> >> back on the first clock if no clk named "PCLK" is found? Otherwise
> >> you still have an incompatible change in the DT binding and it will
> >> break if someone uses an older dtb with a newer kernel.
> >
> > I would like to avoid to hack the kernel code for backward DT compatible
> > things.
> 
> How about a fixup in the platform code to add the property then?

Dunno, do you have an example?

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
