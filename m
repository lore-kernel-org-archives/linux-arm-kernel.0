From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Aug 2017 22:27:44 +0200
Subject: [PATCH v2] ARM: Convert to using %pOF instead of full_name
In-Reply-To: <CAL_JsqJQ7yUhtJca1hupd5zSqo5RTj5k5zc_Ueex1nzbOnjXdw@mail.gmail.com>
References: <20170721192835.25555-1-robh@kernel.org>
 <CAL_JsqJQ7yUhtJca1hupd5zSqo5RTj5k5zc_Ueex1nzbOnjXdw@mail.gmail.com>
Message-ID: <CAK8P3a0UfQ6fThn61Dch1TKPvKkF+7RtDwbv+xhSoWPHNC60hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 10, 2017 at 12:06 AM, Rob Herring <robh@kernel.org> wrote:
> On Fri, Jul 21, 2017 at 2:28 PM, Rob Herring <robh@kernel.org> wrote:
>> Now that we have a custom printf format specifier, convert users of
>> full_name to use %pOF instead. This is preparation to remove storing
>> of the full path string for each node.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
>> Acked-by: Heiko Stuebner <heiko@sntech.de>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>
>>  arch/arm/kernel/cpuidle.c            | 4 ++--
>>  arch/arm/kernel/devtree.c            | 5 ++---
>>  arch/arm/kernel/topology.c           | 3 +--
>>  arch/arm/mach-exynos/suspend.c       | 7 +++----
>>  arch/arm/mach-imx/gpc.c              | 4 ++--
>>  arch/arm/mach-mvebu/kirkwood.c       | 3 +--
>>  arch/arm/mach-omap2/omap-wakeupgen.c | 4 ++--
>>  arch/arm/mach-omap2/omap_hwmod.c     | 4 ++--
>>  arch/arm/mach-rockchip/platsmp.c     | 4 ++--
>>  arch/arm/mach-shmobile/pm-rmobile.c  | 7 +++----
>>  10 files changed, 20 insertions(+), 25 deletions(-)
>
> Arnd, Olof,
>
> Can you please apply this one.

Applied to next/cleanup now, with the Acks. I think that should be the last
patch of this series that you wanted me to apply. Can you double-check
and maybe re-submit any patches I may have missed?

        Arnd
