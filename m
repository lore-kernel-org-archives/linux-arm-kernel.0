From: xuwei5@hisilicon.com (Wei Xu)
Date: Wed, 24 Dec 2014 11:19:14 +0800
Subject: [PATCH 0/7] ARM: hisi: enable HiP01 SoC
In-Reply-To: <1419390602-193123-1-git-send-email-long.wanglong@huawei.com>
References: <1419390602-193123-1-git-send-email-long.wanglong@huawei.com>
Message-ID: <549A30B2.5000408@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2014/12/24 11:09, Wang Long wrote:
> Hi, Xu Wei
> 
> This series patch enable Hisilicon HiP01 SoC. The HiP01 SoC series
> chip is designed for networking product, it integrates a rich peripheral
> interfaces to support network applications and supports both one 
> core or dual cores and quad cores. The core is Cortex A9. 

Hi Wang Long,

> This series patch rebased on Linux 3.19-rc1.

Thanks!
I will pick up these patch set and sent a pull request to arm at kernel.org.

Best Regards,
Wei

> Best Regards
> 
> Wang Long (7):
>   ARM: debug: add HiP01 debug uart
>   ARM: hisi: enable HiP01 SoC
>   ARM: dts: Add hip01-ca9x2 dts file
>   ARM: config: enable ARCH_HIP01
>   ARM: hisi: add a common smp_prepares_cpus function
>   ARM: hisi: rename secondary_startup function
>   ARM: hisi: enable smp for HiP01
> 
>  .../bindings/arm/hisilicon/hisilicon.txt           |  25 +++++
>  arch/arm/Kconfig.debug                             |  10 ++
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/hip01-ca9x2.dts                  |  51 ++++++++++
>  arch/arm/boot/dts/hip01.dtsi                       | 110 +++++++++++++++++++++
>  arch/arm/configs/hisi_defconfig                    |   1 +
>  arch/arm/configs/multi_v7_defconfig                |   1 +
>  arch/arm/mach-hisi/Kconfig                         |   8 ++
>  arch/arm/mach-hisi/core.h                          |   5 +-
>  arch/arm/mach-hisi/headsmp.S                       |   2 +-
>  arch/arm/mach-hisi/hisilicon.c                     |  10 ++
>  arch/arm/mach-hisi/hotplug.c                       |  31 ++++++
>  arch/arm/mach-hisi/platsmp.c                       |  56 ++++++++++-
>  13 files changed, 306 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm/boot/dts/hip01-ca9x2.dts
>  create mode 100644 arch/arm/boot/dts/hip01.dtsi
> 
