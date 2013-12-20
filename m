From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 20 Dec 2013 11:25:40 -0800
Subject: [GIT PULL v2 00/33] Renesas ARM based SoC updates for v3.14
In-Reply-To: <cover.1386897180.git.horms+renesas@verge.net.au> (Simon Horman's
 message of "Fri, 13 Dec 2013 11:29:33 +0900")
References: <cover.1386897180.git.horms+renesas@verge.net.au>
Message-ID: <87mwjvgw97.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon Horman <horms+renesas@verge.net.au> writes:

> Hi Kevin, Hi Olof, Hi Arnd,
>
> please consider these Renesas ARM based SoC updates for v3.14.
>
> As discussed elsewhere, this pull-request also includes defconfig changes
> related to renaming ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY. These are also
> to avoid build regressions when using defconfigs
>
> As this pull request is based on v3.12, which does not include
> genmai_defconfig, it has not been updated. Rather, I have queued up a patch
> in my defconfig to switch it to use ARCH_SHMOBILE_LEGACY.  This does
> involve breaking that defconfig. However as it is new and not in
> wide-spread use it seems better to live with that temporary breakage than
> to have soc depend on defconfig (as was the case in the previous version of
> this pull request).

OK, thanks for the detailed explanation.

> The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
>
>   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v3.14
>
> for you to fetch changes up to fee05eb3d2ce4813b5e9a70ab888d2bc0047f4e1:
>
>   ARM: shmobile: r8a7779: add HSPI clock support for DT (2013-12-10 17:20:15 +0900)
>
> ----------------------------------------------------------------
> Renesas ARM based SoC updates for v3.14
>
> * Rename ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY
>
> * r8a7791 SoC (R-Car M2)
>   - Add thermal platform device
>   - Add DU and LVDS clocks
>   - GPIO platform device support
>   - PFC platform device support
>   - Select IRQC
>
> * r8a7790 SoC (R-Car H2)
>   - Tidyup clock table order
>   - Fixup I2C clock source
>   - Correct EXTAL divider settings
>   - Add clocks for thermal devices and SSI
>
> * r8a7779 SoC (R-Car H1)
>   - Add I2C clock for DT
>
> * r8a7778 SoC (R-Car M1)
>   - Add HSPI clocks for DT
>   - Add I2C clock for DT
>   - Add HPBIFx DMAEngine support
>
> * r8a7740 SoC (R-Mobile A1)
>   - Add FSI clocks for DT
>
> * emev2 SoC (Emma Mobile)
>   - Move to Multi-platform
>   - Remove legacy board code
>
> * r7s72100 SoC (RZ/A1H)
>   - Select GPIO
>
> * r8a73a4 SoC (R-Mobile APE6)
>   - Don't used named IRC for DMAEngine
>
> ----------------------------------------------------------------

Pulled into next/soc.

Kevin
