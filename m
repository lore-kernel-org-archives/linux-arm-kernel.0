From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 22 Feb 2016 13:44:00 +0100
Subject: [GIT PULL] ARM: mediatek: soc updates for v4.5
In-Reply-To: <CABuKBeLEf+jyE5gzWEVzfRZ7DwRgnLrdWLREwqqfYGBb2g+exQ@mail.gmail.com>
References: <CABuKBeLEf+jyE5gzWEVzfRZ7DwRgnLrdWLREwqqfYGBb2g+exQ@mail.gmail.com>
Message-ID: <CABuKBeKf4dB7Y6A9WN530Zfmk55TXYserHv9OL-8Atfg65tTjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These updates are of course for v4.6, sorry for the confusion.

Matthias

2016-02-22 13:40 GMT+01:00 Matthias Brugger <matthias.bgg@gmail.com>:
> Hi Arnd and Olof,
>
> Please pull the following patches.
> As you can see from the description, this pull request includes some
> fixes. Only a few developer have access to a Mediatek HW at the
> moment. Therefor I didn't send the fixes to stable.
>
> If you want me to send the fixes for older kernel versions, please let me know.
>
> Thanks,
> Matthias
>
> ---
>
> The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:
>
> Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)
>
> are available in the git repository at:
>
> https://github.com/mbgg/linux-mediatek.git tags/v4.5-next-soc
>
> for you to fetch changes up to cc8ed76938b5cf6a54ab3d60edabaf808dc960d1:
>
> soc: mediatek: SCPSYS: Fix double enabling of regulators (2016-02-01
> 11:28:07 +0100)
>
> ----------------------------------------------------------------
> Fix state machine implemenation of PMIC wrapper.
> Add SMP support for mt7623.
> Disable watchdog of STAUPD in PMIC wrapper for mt8173.
> Add SMP support for mt2701.
> Use builtin_platform_driver for scpsys. Driver can't be build as module.
> Fix regulator enablement in scpsys.
>
> ----------------------------------------------------------------
> Henry Chen (2):
> soc: mediatek: PMIC wrap: Clear the vldclr if state machine stay on
> FSM_VLDCLR state.
> soc: mediatek: PMIC wrap: clear the STAUPD_TRIG bit of WDT_SRC_EN
>
> John Crispin (1):
> ARM: mediatek: add MT7623 smp bringup code
>
> Louis Yu (1):
> ARM: mediatek: add mt2701 smp bringup code
>
> Matthias Brugger (1):
> soc: mediatek: SCPSYS: use builtin_platform_driver
>
> Sascha Hauer (1):
> soc: mediatek: SCPSYS: Fix double enabling of regulators
>
> arch/arm/mach-mediatek/platsmp.c | 8 +++++
> drivers/soc/mediatek/mtk-pmic-wrap.c | 41 +++++++++++++++++++++---
> drivers/soc/mediatek/mtk-scpsys.c | 60 ++++++++++++++++--------------------
> 3 files changed, 71 insertions(+), 38 deletions(-)



-- 
motzblog.wordpress.com
