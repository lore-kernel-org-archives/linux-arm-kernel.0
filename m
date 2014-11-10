From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 10 Nov 2014 17:13:05 +0200
Subject: [PATCH v4 0/2] ARM: keystone: pm: switch to use generic pm domains
In-Reply-To: <1415631557-22897-1-git-send-email-grygorii.strashko@ti.com>
References: <1415631557-22897-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <5460D601.70504@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

On 11/10/2014 04:59 PM, Grygorii Strashko wrote:
> Hi Santosh, Kevin,
> 
> This series switches Keystone 2 PM code to use Generic PM domains
> instead of PM clock domains because of the lack of DT support
> for the last.
> It will finally allow to enable Runtime PM for Keystone 2.
> 
> This series based on top
> 
> Changes in v4:
>   - changes for Generic clock manipulation PM callbacks (clock_ops.c)
>     were separated in standalone series [3] and Keystone 2 specific
>     patches were rebased on top of it.

I've just found that prerequisite patches have been taken by Rafael in linux-pm.git/linux-next,
first two patches from series:
 "[PATCH v4 0/3] PM / clock_ops: add pm_clk_add_clk()"
 https://lkml.org/lkml/2014/11/6/319 

Thanks a lot Rafael.

So, if no complains, this series is ready.

> 
> Changes in v3:
>   - handling of the case when !CONFIG_PM_RUNTIME has been
>     moved in PM clock framework.
> 
> Changes in v2:
> - minor comments applied and rebased on top of Linux 3.18-rc1.
> 
> Links on previous versions:
> v2:  https://lkml.org/lkml/2014/10/20/248
> v1:  https://lkml.org/lkml/2014/9/29/382
> 
> RFC version of patches can be found at [2].
> 
> [1] "[PATCH/RFC 0/4] of: Register clocks for Runtime PM with PM core"
>    https://lkml.org/lkml/2014/4/24/1118
> 
> [2] "[RFC PATCH 0/4] ARM: keystone: pm: switch to use generic pm domains"
>    https://lkml.org/lkml/2014/9/25/364
> 
> [3] "[PATCH v4 0/3] PM / clock_ops: add pm_clk_add_clk()"
>    https://lkml.org/lkml/2014/11/6/319
> 
> CC: Santosh Shilimkar <ssantosh@kernel.org>
> CC: Kevin Hilman <khilman@linaro.org>
> CC: Ulf Hansson <ulf.hansson@linaro.org>
> CC: Geert Uytterhoeven <geert@linux-m68k.org>
> CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Grygorii Strashko (2):
>    ARM: keystone: pm: switch to use generic pm domains
>    ARM: dts: keystone: add generic pm controller node
> 
>   .../bindings/power/ti,keystone-powerdomain.txt     |  31 ++++++
>   arch/arm/boot/dts/keystone.dtsi                    |   6 ++
>   arch/arm/mach-keystone/Kconfig                     |   1 +
>   arch/arm/mach-keystone/pm_domain.c                 | 106 ++++++++++++++-------
>   4 files changed, 107 insertions(+), 37 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/power/ti,keystone-powerdomain.txt
> 

regards,
-grygorii
