From: olof@lixom.net (Olof Johansson)
Date: Fri, 23 Oct 2015 10:24:31 -0700
Subject: [resend GIT PULL] ARM: mediatek: soc updates for v4.3
In-Reply-To: <CABuKBeJUgmaswptkh1MdFfLyL0Yir7Umf=KQ3kW3B2A_=SU+0A@mail.gmail.com>
References: <CABuKBeJUgmaswptkh1MdFfLyL0Yir7Umf=KQ3kW3B2A_=SU+0A@mail.gmail.com>
Message-ID: <20151023172431.GI2224@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 18, 2015 at 02:20:17PM +0200, Matthias Brugger wrote:
> Hi Arnd and Olof,
> 
> Please pull the following patches.
> 
> I resend this pull request, because I forgot to add the arm mailing
> list in the first place.
> 
> Thanks,
> Matthias
> 
> ---
> 
> The following changes since commit 1f93e4a96c9109378204c147b3eec0d0e8100fde:
> 
>   Linux 4.3-rc2 (2015-09-20 14:32:34 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/mbgg/linux-mediatek.git tags/v4.3-next-soc
> 
> for you to fetch changes up to 0cda07001a9454f371b7a7edabad55d99ef91157:
> 
>   ARM: mediatek: add smp bringup code (2015-10-14 15:34:44 +0200)
> 
> ----------------------------------------------------------------
> Do the initial setting of the pmic wrap interrupt before requesting
> the interrupt.
> This fixes the corner-case where the pmic is initialized by the bootloader, but
> not the pmic watchdog.
> 
> Add support for active wakeup to the scpsys. This allows to keep the power of
> a scpsys domain  during suspend state.
> 
> With version v4.3 new subsystem clocks are added to the clock dirver. In late
> init the kernel turns off all unused clocks. This can provoke a hang if
> the kernel tries to access the venc and venc_lt power domain registers.
> Add the necessary parent clocks for this power domains to
> the scpsys so that no random hang happens.
> 
> The bootloader of mt6589, mt8135 and mt1827 does not turn on the arm-arch-timer.
> As there is no opensource bootloader in the near future for this architectures
> we enable the arch timer at kernel boot. We need the arch timer for SMP boot.
> 
> Add support for SMP on mt6589, mt8127 and mt8135.

Hi,


>  arch/arm/mach-mediatek/Makefile      |   3 +
>  arch/arm/mach-mediatek/mediatek.c    |  27 +++++++
>  arch/arm/mach-mediatek/platsmp.c     | 141 +++++++++++++++++++++++++++++++++++
>  drivers/soc/mediatek/mtk-pmic-wrap.c |  10 ++-
>  drivers/soc/mediatek/mtk-scpsys.c    |  83 +++++++++++++++------

The changes to driver/soc and the ones to arch/arm/mach-mediatek seem to be
mostly independent functionally. For those that are, in the future please send
drivers/soc in a separate branch (since we'd merge that through the drivers
branch in our tree).

Merged into next/soc. Thanks!


-Olof
