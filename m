From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 10 Jun 2013 21:12:48 +0900
Subject: [PATCH V2] ARM: EXYNOS: no more support non-DT for EXYNOS SoCs
In-Reply-To: <4648637.k6B8xKB55c@amdc1227>
References: <0a1201ce6268$d5a51610$80ef4230$%kim@samsung.com>
 <4648637.k6B8xKB55c@amdc1227>
Message-ID: <51B5C2C0.1000205@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/13 21:00, Tomasz Figa wrote:
> Hi Kukjin,
>
> On Thursday 06 of June 2013 12:49:23 Kukjin Kim wrote:
>> As we discussed in mailing list, non-DT for EXYNOS SoCs will not be
>> supported from v3.11. This patch removes regarding files for non-DT
>> including board files and defconfig.
>>
>> Cc: Sylwester Nawrocki<s.nawrocki@samsung.com>
>> Cc: Tomasz Figa<t.figa@samsung.com>
>> Cc: Thomas Abraham<thomas.ab@samsung.com>
>> Cc: Kyungmin Park<kyungmin.park@samsung.com>
>> Cc: Arnd Bergmann<arnd@arndb.de>
>> Cc: Olof Johansson<olof@lixom.net>
>> Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>
>> ---
>>
>> It's time to remove non-DT stuff for EXYNOS SoCs.
>> If no objection on this, this will be sent to arm-soc in a couple of days.
>>
>> - Kukjin
>>
>>   arch/arm/configs/exynos4_defconfig         |   68 --
>>   arch/arm/mach-exynos/Kconfig               |  320 +------
>>   arch/arm/mach-exynos/Makefile              |   26 -
>>   arch/arm/mach-exynos/common.c              |   10 -
>>   arch/arm/mach-exynos/dev-ahci.c            |  255 -----
>>   arch/arm/mach-exynos/dev-ohci.c            |   52 --
>>   arch/arm/mach-exynos/dma.c                 |  322 -------
>>   arch/arm/mach-exynos/mach-armlex4210.c     |  207 -----
>>   arch/arm/mach-exynos/mach-nuri.c           | 1388
>> ---------------------------- arch/arm/mach-exynos/mach-origen.c         |
>> 823 ----------------- arch/arm/mach-exynos/mach-smdk4x12.c       |  396
>> --------
>>   arch/arm/mach-exynos/mach-smdkv310.c       |  444 ---------
>>   arch/arm/mach-exynos/mach-universal_c210.c | 1159 -----------------------
>>   arch/arm/mach-exynos/pm_domains.c          |    7 -
>>   arch/arm/mach-exynos/setup-fimc.c          |   44 -
>>   arch/arm/mach-exynos/setup-fimd0.c         |   43 -
>>   arch/arm/mach-exynos/setup-i2c1.c          |   23 -
>>   arch/arm/mach-exynos/setup-i2c2.c          |   23 -
>>   arch/arm/mach-exynos/setup-i2c3.c          |   23 -
>>   arch/arm/mach-exynos/setup-i2c4.c          |   23 -
>>   arch/arm/mach-exynos/setup-i2c5.c          |   23 -
>>   arch/arm/mach-exynos/setup-i2c6.c          |   23 -
>>   arch/arm/mach-exynos/setup-i2c7.c          |   23 -
>>   arch/arm/mach-exynos/setup-keypad.c        |   36 -
>>   arch/arm/mach-exynos/setup-sdhci-gpio.c    |  152 ---
>>   arch/arm/mach-exynos/setup-spi.c           |   45 -
>>   arch/arm/mach-exynos/setup-usb-phy.c       |  223 -----
>>   27 files changed, 1 insertion(+), 6180 deletions(-)
>>   delete mode 100644 arch/arm/configs/exynos4_defconfig
>>   delete mode 100644 arch/arm/mach-exynos/dev-ahci.c
>>   delete mode 100644 arch/arm/mach-exynos/dev-ohci.c
>>   delete mode 100644 arch/arm/mach-exynos/dma.c
>>   delete mode 100644 arch/arm/mach-exynos/mach-armlex4210.c
>>   delete mode 100644 arch/arm/mach-exynos/mach-nuri.c
>>   delete mode 100644 arch/arm/mach-exynos/mach-origen.c
>>   delete mode 100644 arch/arm/mach-exynos/mach-smdk4x12.c
>>   delete mode 100644 arch/arm/mach-exynos/mach-smdkv310.c
>>   delete mode 100644 arch/arm/mach-exynos/mach-universal_c210.c
>>   delete mode 100644 arch/arm/mach-exynos/setup-fimc.c
>>   delete mode 100644 arch/arm/mach-exynos/setup-fimd0.c
>>   delete mode 100644 arch/arm/mach-exynos/setup-i2c1.c
>>   delete mode 100644 arch/arm/mach-exynos/setup-i2c2.c
>>   delete mode 100644 arch/arm/mach-exynos/setup-i2c3.c
>>   delete mode 100644 arch/arm/mach-exynos/setup-i2c4.c
>>   delete mode 100644 arch/arm/mach-exynos/setup-i2c5.c
>>   delete mode 100644 arch/arm/mach-exynos/setup-i2c6.c
>>   delete mode 100644 arch/arm/mach-exynos/setup-i2c7.c
>>   delete mode 100644 arch/arm/mach-exynos/setup-keypad.c
>>   delete mode 100644 arch/arm/mach-exynos/setup-sdhci-gpio.c
>>   delete mode 100644 arch/arm/mach-exynos/setup-spi.c
>>   delete mode 100644 arch/arm/mach-exynos/setup-usb-phy.c
>>
>
> Something is either wrong with the patch or my git/patch skills, because I
> can't apply this patch in any way, getting:
>
> $ git am -3 \[PATCH\ V2\]\ ARM_EXYNOS_no\ more\ support\ non-DT\ for\ EXYNOS\
> SoCs.mbox

[...]

> Did you hand edit your patch?
> It does not apply to blobs recorded in its index.
> Cannot fall back to three-way merge.
> Patch failed at 0001 ARM: EXYNOS: no more support non-DT for EXYNOS SoCs
> The copy of the patch that failed is found in:
>     /home/t.figa/linux-patches/.git/rebase-apply/patch
> When you have resolved this problem, run "git am --resolved".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
> I will try to apply it manually, but it would be nice to know what I am doing
> wrong.
>
Tomasz, you may use my branch, for-next or 
v3.11-next/remove-non-DT-exynos in samsung tree for test on your board.

Thanks.

- Kukjin
