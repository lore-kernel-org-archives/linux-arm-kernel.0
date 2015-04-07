From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 07 Apr 2015 14:28:33 +0200
Subject: linux-next: build failure after merge of the arm-soc tree
In-Reply-To: <CACRpkdZE0JB0xBENNPhi6g4Su5ZuZA0wf1mi8xzbLeKm3rOYjA@mail.gmail.com>
References: <20150407111217.2b2cf440@canb.auug.org.au>
 <CABuKBe+iBfmxHat3Ezinpd-85CA5m1f2gYydk=uW4SwABQ-0Wg@mail.gmail.com>
 <CACRpkdZE0JB0xBENNPhi6g4Su5ZuZA0wf1mi8xzbLeKm3rOYjA@mail.gmail.com>
Message-ID: <2111946.bc0NbpO0Gp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 April 2015 11:28:22 Linus Walleij wrote:
> On Tue, Apr 7, 2015 at 10:43 AM, Matthias Brugger
> <matthias.bgg@gmail.com> wrote:
> > 2015-04-07 3:12 GMT+02:00 Stephen Rothwell <sfr@canb.auug.org.au>:
> >> Hi all,
> >>
> >> After merging the arm-soc tree, today's linux-next build (arm
> >> multi_v7_defconfig) failed like this:
> >>
> >> In file included from arch/arm/boot/dts/mt8135.dtsi:18:0,
> >>                  from arch/arm/boot/dts/mt8135-evbp1.dts:16:
> >> arch/arm/boot/dts/mt8135-pinfunc.h:18:40: fatal error: dt-bindings/pinctrl/mt65xx.h: No such file or directory
> >>  #include <dt-bindings/pinctrl/mt65xx.h>
> >>                                         ^
> >>
> >> Caused by commit e6f219b8ec5e ("ARM: dts: mt8135: Add pinctrl/GPIO/EINT
> >> node for mt8135").
> >
> > This will be fixed as soon as Linus pinctrl for-next branch got merged [1].
> 
> Hm that's unfortunate, we do not rely on merge orders.
> 
> Either the ARM SoC tree needs to pull in the pinctrl commit
> or I need to carry this patch in the pinctrl tree.
> 
> Is this sufficiently stand-alone to be merged into my tree
> or do you need to go by the former approach?

Let's just delay this patch to another merge window. You can add the
driver now, and we should just revert the DT node addition in arm-soc,
and then we'll add it in 4.2, or come up with a better solution.

It's possible that we can come up with a way to avoid defining macros
for the pinctrl tables here.

	Arnd
