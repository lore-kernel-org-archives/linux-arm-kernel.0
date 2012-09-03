From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 3 Sep 2012 12:47:51 +0200
Subject: [PATCH] ARM: ux500: Fix build error due to missing include of
 asm/pmu.h in cpu-db8500.c
In-Reply-To: <1346588747.7909.2.camel@phoenix>
References: <1346588747.7909.2.camel@phoenix>
Message-ID: <CACRpkdYxYGa=C092rbTU5bo=YEu6wqiTUD7W4pLS_wNfmAe4Zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 2, 2012 at 2:25 PM, Axel Lin <axel.lin@gmail.com> wrote:

> Include asm/pmu.h to fix below build error:
>
>   CC      arch/arm/mach-ux500/cpu-db8500.o
> arch/arm/mach-ux500/cpu-db8500.c:118:8: error: variable 'db8500_pmu_platdata' has initializer but incomplete type
> arch/arm/mach-ux500/cpu-db8500.c:119:2: error: unknown field 'handle_irq' specified in initializer
> arch/arm/mach-ux500/cpu-db8500.c:119:2: warning: excess elements in struct initializer [enabled by default]
> arch/arm/mach-ux500/cpu-db8500.c:119:2: warning: (near initialization for 'db8500_pmu_platdata') [enabled by default]
> make[1]: *** [arch/arm/mach-ux500/cpu-db8500.o] Error 1
> make: *** [arch/arm/mach-ux500] Error 2
>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

That's on linux-next not on v3.6-rcN right?

I've applied it to my ux500 branch and will carry it unless Will Deacon
express an interest in it, PMU is his territory...

Yours,
Linus Walleij
