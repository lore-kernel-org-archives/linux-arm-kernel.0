From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 6 Jun 2014 21:14:01 +0900
Subject: [PATCH] PM / OPP: Remove ARCH_HAS_OPP
In-Reply-To: <20140606111411.GD25896@verge.net.au>
References: <1402051016-28853-1-git-send-email-broonie@kernel.org>
 <20140606111411.GD25896@verge.net.au>
Message-ID: <CANqRtoTy_LwSiZgRFEw5Ly4ojfinoCichxrX7cO6m2XB9JGoww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 6, 2014 at 8:14 PM, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Jun 06, 2014 at 11:36:56AM +0100, Mark Brown wrote:
>> From: Mark Brown <broonie@linaro.org>
>>
>> Since the OPP layer is a kernel library which has been converted to be
>> directly selectable by its callers rather than user selectable and
>> requiring architectures to enable it explicitly the ARCH_HAS_OPP symbol
>> has become redundant and can be removed. Do so.
>>
>> Signed-off-by: Mark Brown <broonie@linaro.org>
>> ---
>>  Documentation/power/opp.txt    | 3 ---
>>  arch/arm/mach-exynos/Kconfig   | 1 -
>>  arch/arm/mach-highbank/Kconfig | 1 -
>>  arch/arm/mach-imx/Kconfig      | 1 -
>>  arch/arm/mach-omap2/Kconfig    | 1 -
>>  arch/arm/mach-shmobile/Kconfig | 2 --
>>  arch/arm/mach-vexpress/Kconfig | 1 -
>>  arch/arm/mach-zynq/Kconfig     | 1 -
>>  drivers/devfreq/Kconfig        | 1 -
>>  kernel/power/Kconfig           | 3 ---
>>  10 files changed, 15 deletions(-)
>
> shmobile portion:
>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>

Hi Simon, Mark,

Nice to see cleanups in this area. Reducing the number of Kconfig
symbols must be a good thing.

I'm not sure about the expected merge order for this kind of change vs
queued up stuff in the renesas git tree, but I believe the following
patch selects ARCH_HAS_OPP:

[PATCH v3] ARM: shmobile: Mark all SoCs in shmobile as CPUFreq, capable

Cheers,

/ magnus
