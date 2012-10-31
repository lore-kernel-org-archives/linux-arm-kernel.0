From: viresh.kumar@linaro.org (viresh kumar)
Date: Wed, 31 Oct 2012 23:13:04 +0530
Subject: [PATCH v2 2/5] ARM: gic: remove direct use of gic_raise_softirq
In-Reply-To: <1351695517-5636-3-git-send-email-robherring2@gmail.com>
References: <1351695517-5636-1-git-send-email-robherring2@gmail.com>
 <1351695517-5636-3-git-send-email-robherring2@gmail.com>
Message-ID: <CAOh2x=nu7VstzDHp1BS2qUEP9Bv9E+gA-zcZULRNqOdU2uedww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2012 at 8:28 PM, Rob Herring <robherring2@gmail.com> wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> In preparation of moving gic code to drivers/irqchip, remove the direct
> platform dependencies on gic_raise_softirq. Move the setup of
> smp_cross_call into the gic code. Now that all platforms are using IPI#0
> for core wakeup, create a common wakeup ipi function.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Daniel Walker <dwalker@fifo99.com>
> Cc: Bryan Huntsman <bryanh@codeaurora.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: Shiraz Hashim <shiraz.hashim@st.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/common/gic.c               |   45 +++++++++++++++++++----------------
>  arch/arm/include/asm/hardware/gic.h |    1 -
>  arch/arm/include/asm/smp.h          |    1 +
>  arch/arm/kernel/smp.c               |    5 ++++
>  arch/arm/mach-exynos/platsmp.c      |    4 +---
>  arch/arm/mach-highbank/platsmp.c    |    4 +---
>  arch/arm/mach-imx/platsmp.c         |    2 --
>  arch/arm/mach-msm/platsmp.c         |    4 +---
>  arch/arm/mach-omap2/omap-smp.c      |    4 +---
>  arch/arm/mach-realview/platsmp.c    |    2 --
>  arch/arm/mach-shmobile/platsmp.c    |    2 --
>  arch/arm/mach-shmobile/smp-emev2.c  |    2 +-
>  arch/arm/mach-spear13xx/platsmp.c   |    2 --

For SPEAr:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
