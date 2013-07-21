From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 21 Jul 2013 14:04:52 +0400
Subject: [PATCH 08/10] ARM: clps711x: Add CLPS711X cpuidle driver
In-Reply-To: <51EB9C9F.5040405@linaro.org>
References: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
 <1374172501-26796-9-git-send-email-shc_work@mail.ru>
 <51EB0433.3050308@linaro.org>
 <20130721081138.75cf5437bc30f42284f12e47@mail.ru>
 <51EB9C9F.5040405@linaro.org>
Message-ID: <20130721140452.826cb0b8f8f5ab01867aec90@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 21 Jul 2013 10:32:31 +0200
Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> On 07/21/2013 06:11 AM, Alexander Shiyan wrote:
> > On Sat, 20 Jul 2013 23:42:11 +0200
> > Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> > 
> >> On 07/18/2013 08:34 PM, Alexander Shiyan wrote:
> >>> This adds the cpuidle driver for Cirrus Logic CLPS711X series SoCs.
> >>> Designed primarily for migration CLPS711X subarch for multiplatform & DT.
> >>>
> >>> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> >>> ---
> >>>  drivers/cpuidle/Kconfig            |  6 +++
> >>>  drivers/cpuidle/Makefile           |  1 +
> >>>  drivers/cpuidle/cpuidle-clps711x.c | 80 ++++++++++++++++++++++++++++++++++++++
> >>>  3 files changed, 87 insertions(+)
> >>>  create mode 100644 drivers/cpuidle/cpuidle-clps711x.c
> > [...]
> >>> +static int clps711x_cpuidle_halt(struct cpuidle_device *dev,
> >>> +				 struct cpuidle_driver *drv, int index)
> >>> +{
> >>> +	writel(1, clps711x_halt);
> >>
> >> In what the 'clps711x_halt' differs from the usual WFI (cpu_do_idle) ?
> > 
> > AFAIK, ARM720T does not implement the WFI instruction.
> > "HALT" register in CLPS711X do the same:
> > "A write to this location will put the system into the Idle State by
> > halting the clock to the processor until an interrupt is generated."
> 
> I am wondering if you are not using more states, may be you can consider
> to add a clps711x idle function for the 'arm_pm_idle' callback instead
> of creating a new driver.

Currently, this is exactly what is done :)
But I really would like to further add a second mode (STDBY),
which allow to use all PM features.
At this time add this mode is too hard, because there are some barriers
for this, which will be resolved when all drivers for this platform will
contains DT-support.

[...]

-- 
Alexander Shiyan <shc_work@mail.ru>
