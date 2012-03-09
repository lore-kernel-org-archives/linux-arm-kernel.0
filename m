From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Fri, 9 Mar 2012 16:06:15 +0900
Subject: [GIT PULL] Samsung Cleanup EXYNOS clock for v3.4
In-Reply-To: <22926872.16671331267895327.JavaMail.weblogic@epml04>
References: <22926872.16671331267895327.JavaMail.weblogic@epml04>
Message-ID: <CAJ0PZbQebwvFrmXWn=-m7YH3Ri7t2fvm+E_EKZ45rD7cAyo2UA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/3/9 ??? <myungjoo.ham@samsung.com>:
>> Hi Arnd, Olof,
>>
>> Here is cleanup clock part for EXYNOS SoCs from:
>>    git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
>> next/cleanup-exynos-clock
>>
>> Please pull and if any problems, please kindly let me know.
>
> Hello,
>
> It appears that some patches are missing in this branch; i.e., you seemed not to have pulled one required by this patchset: http://permalink.gmane.org/gmane.linux.kernel.samsung-soc/8474
>
> If the missing patches are included in another branch of yours and being pulled at somewhere else, please never mind. However, it doesn't appear so.
>
> Anyway, I'm rebasing the pull-requested branch upon most recent RC, so it'll be available soon (in an hour?) at http://git.infradead.org/users/kmpark/linux-samsung/shortlog/refs/heads/devfreq-for-samsung
>
>
> Cheers!
> MyungJoo.
>

Hello, Kgene

I've rebased the branch that was pull-requested to Kgene based on this branch.

http://git.infradead.org/users/kmpark/linux-samsung/shortlog/refs/heads/devfreq-for-samsung


The following changes since commit e01127814c640f6cd06a5c06731c6d1ee8c45101:

  PM / devfreq: update the name of EXYNOS clock register (2012-03-07
03:25:31 -0800)

are available in the git repository at:
  git://git.infradead.org / users/kmpark/linux-samsung devfreq-for-samsung

MyungJoo Ham (4):
      ARM: EXYNOS4: Add DMC1, allow PPMU access for DMC.
      ARM: EXYNOS4: Add clock register addresses for Exynos4x12 bus
devfreq driver
      ARM Exynos4210-Nuri: support Exynos4210-bus Devfreq driver.
      PM / devfreq: update the name of EXYNOS clock registers that were omitted.

 arch/arm/mach-exynos/common.c                  |    7 +++-
 arch/arm/mach-exynos/include/mach/map.h        |    1 +
 arch/arm/mach-exynos/include/mach/regs-clock.h |   42 ++++++++++++++++++++++++
 arch/arm/mach-exynos/mach-nuri.c               |   11 ++++--
 drivers/devfreq/exynos4_bus.c                  |    6 ++--
 5 files changed, 60 insertions(+), 7 deletions(-)



>>
>> The following changes since commit b01543dfe67bb1d191998e90d20534dc354de059:
>>
>>    Linux 3.3-rc4 (2012-02-18 15:53:33 -0800)
>>
>> are available in the git repository at:
>>    git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
>> next/cleanup-exynos-clock
>>
>> Kukjin Kim (2):
>>        ARM: EXYNOS: cleanup clock part for new EXYNOS SoCs
>>        PM / devfreq: update the name of EXYNOS clock register
>>
>>   arch/arm/mach-exynos/Makefile                     |    3 +-
>>   arch/arm/mach-exynos/clock-exynos4.c              | 1564
>> +++++++++++++++++++++
>>   arch/arm/mach-exynos/clock-exynos4.h              |   32 +
>>   arch/arm/mach-exynos/clock-exynos4210.c           |   46 +-
>>   arch/arm/mach-exynos/clock-exynos4212.c           |   30 +-
>>   arch/arm/mach-exynos/clock.c                      | 1564
>> ---------------------
>>   arch/arm/mach-exynos/common.h                     |    9 +
>>   arch/arm/mach-exynos/include/mach/exynos4-clock.h |   43 -
>>   arch/arm/mach-exynos/include/mach/regs-clock.h    |  364 +++---
>>   arch/arm/mach-exynos/pm.c                         |   40 +-
>>   drivers/devfreq/exynos4_bus.c                     |  224 ++--
>>   11 files changed, 1959 insertions(+), 1960 deletions(-)
>>   create mode 100644 arch/arm/mach-exynos/clock-exynos4.c
>>   create mode 100644 arch/arm/mach-exynos/clock-exynos4.h
>>   delete mode 100644 arch/arm/mach-exynos/clock.c
>>   delete mode 100644 arch/arm/mach-exynos/include/mach/exynos4-clock.h
>>



-- 
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab, DMC Business, Samsung Electronics
