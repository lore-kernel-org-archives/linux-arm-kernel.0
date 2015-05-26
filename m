From: lznuaa@gmail.com (Zhi Li)
Date: Tue, 26 May 2015 10:01:00 -0500
Subject: [PATCH v2 1/2] ARM: imx: enable smp for i.MX7D
In-Reply-To: <20150525081928.GK3264@dragon>
References: <1432147961-3547-1-git-send-email-Frank.Li@freescale.com>
 <20150525081928.GK3264@dragon>
Message-ID: <CAHrpEqS1ESjTdAq-ncm597kAt3D6GbmTSAtNchu-aTwFatKpdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 25, 2015 at 3:19 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Thu, May 21, 2015 at 02:52:40AM +0800, Frank.Li at freescale.com wrote:
>> From: Frank Li <Frank.Li@freescale.com>
>>
>> i.MX7D have two cores.
>> enable multicore support.
>> enable cpu hotplug support.
>>
>> Signed-off-by: Frank Li <Frank.Li@freescale.com>
>> Signed-off-by: Anson Huang <b20788@freescale.com>
>> ---
>>
>> This patch is based on Russel king's
>> ARM: v7 setup function should invalidate L1 cache
>
> So we will need to wait for Russell's patch to land on mainline first.
>
>>
>> Change from V1 to V2
>>  - base on ARM: v7 setup function should invalidate L1 cache
>>  - remove unused define in gpcv2.c
>>  - change name imx_gpcv2_set_core1_pdn_pup_by_software to imx_gpcv2_set_core1_power
>>  - add timeout check.
>>  - Change to BUG_ON
>>  - Change use enable-method
>>
>>  arch/arm/mach-imx/Kconfig      |  6 ++++
>>  arch/arm/mach-imx/Makefile     |  1 +
>>  arch/arm/mach-imx/common.h     |  4 +++
>>  arch/arm/mach-imx/gpcv2.c      | 67 ++++++++++++++++++++++++++++++++++++++++++
>>  arch/arm/mach-imx/hotplug.c    | 18 ++++++++++++
>>  arch/arm/mach-imx/mach-imx7d.c |  1 +
>>  arch/arm/mach-imx/platsmp.c    | 18 ++++++++++++
>>  arch/arm/mach-imx/src.c        | 35 ++++++++++++++++++++--
>>  8 files changed, 147 insertions(+), 3 deletions(-)
>>  create mode 100644 arch/arm/mach-imx/gpcv2.c
>
> Honestly, I do not like the software version numbering which is quite
> arbitrary and may conflict with hardware one some day.

what's name do you prefer?

>
> More importantly, is i.MX7 GPC block really so different from i.MX6 one
> and worth a new driver for it?  If you check the latest GPC driver, you
> will find that it evolves a lot recently and becomes a driver handles
> not only core power but also PU power domains, and also we have
> implemented stacked IRQ domain for it.   Are you going to redo all these
> for this gpcv2 driver?

Totally difference.

http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/arch/arm/mach-imx/gpcv2.c?h=imx_3.14.28_7d_alpha&id=a34e259cc0a4e86ccb993c947991d2823d81eb14

Only simular part is that GPC irq mask, which only bit possition and
register offfset change.

Suspend/Resume flow also changed.

shenwei is working on that.


best regards
Frank Li

>
> Shawn
