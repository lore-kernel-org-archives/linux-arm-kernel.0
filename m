From: kgene@kernel.org (Kukjin Kim)
Date: Sun, 16 Nov 2014 16:01:15 +0900
Subject: [PATCH v7 0/7] Enable support for Samsung Exynos7 SoC
In-Reply-To: <CAM4voa=DT80ceZf3P8g5+80hoBKQrviSCHcc1qj--RLJkFxbyQ@mail.gmail.com>
References: <1415506834-8180-1-git-send-email-a.kesavan@samsung.com>
 <CAM4voanLYH+aEhKq_P+pTde5XL4dS0ZjvXta-2U4k0CdV6vYKQ@mail.gmail.com>
 <CAM4voa=DT80ceZf3P8g5+80hoBKQrviSCHcc1qj--RLJkFxbyQ@mail.gmail.com>
Message-ID: <000e01d0016b$1eef44b0$5ccdce10$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Abhilash Kesavan wrote:
> 
> Hi Olof and Arnd
> 
Hi

> On Tue, Nov 11, 2014 at 7:59 PM, Abhilash Kesavan
> <kesavan.abhilash@gmail.com> wrote:
> > Hello Olof and Arnd,
> >
> > On Sun, Nov 9, 2014 at 9:50 AM, Abhilash Kesavan <a.kesavan@samsung.com> wrote:
> >> These were originally part of 2 patchsets[1][2] adding support for Exynos7.
> >>  The clock and pinctrl patches are going through the respective maintainer's
> >> tree; hence the remaining dt related patches have been consolidated and are
> >> being posted here as a separate series.
> >>
> >> This patchset has build dependencies on the following patches:
> >> a] "[GIT PULL] Samsung clock changes for 3.19" - specifically the clock dt
> >>    bindings header.
> >>    http://comments.gmane.org/gmane.linux.kernel.samsung-soc/39142
> >> b] "tty: serial: samsung: Clean-up selection of number of available UARTs"
> >>    http://www.spinics.net/lists/linux-samsung-soc/msg37418.html
> >> c] "dts, kbuild: Implement support for dtb vendor subdirs"(merged in linux-next)
> >>    https://lkml.org/lkml/2014/10/21/654
> >>
> >> [1] arch: arm64: Enable support for Samsung Exynos7 SoC
> >> http://www.spinics.net/lists/linux-samsung-soc/msg37047.html
> >> [2] Add clock and DT support for a few IPs on Exynos7
> >> http://www.spinics.net/lists/linux-samsung-soc/msg37973.html
> >>
> >> Changes since v6:
> >>         - Fixed the platform ordering (exynos before thunder) in Kconfig file.
> >>         - Fixed the ordering of reg and enable-method properties in cpu node
> >>         as per Lorenzo Pieralisi's comment.
> >
> >
> > Do you have any comments on this patchset ?
> 
> A gentle reminder regarding this patch set. Kindly review.
> 
As I commented before, looks good to me, so shall I queue this in samsung tree
with dependencies such as clock stuff? I'm happy with either way samsung tree
or arm-soc tree directly though.

Thanks,
Kukjin

> Abhilash
> >>
> >> Abhilash Kesavan (2):
> >>   arm64: dts: Add PMU DT node for exynos7 SoC
> >>   arm64: dts: Add nodes for mmc, i2c, rtc, watchdog, adc on Exynos7
> >>
> >> Alim Akhtar (2):
> >>   arm64: exynos7: Enable ARMv8 based Exynos7 (SoC) support
> >>   arm64: Enable Exynos7 SOC in the defconfig
> >>
> >> Naveen Krishna Ch (2):
> >>   arm64: dts: Add initial device tree support for EXYNOS7
> >>   arm64: dts: Add initial pinctrl support to EXYNOS7
> >>
> >> Pankaj Dubey (1):
> >>   arm64: dts: add <dt-bindings/> symlink
> >>
> >>  .../devicetree/bindings/arm/samsung/pmu.txt        |   1 +
> >>  arch/arm64/Kconfig                                 |  17 +
> >>  arch/arm64/boot/dts/Makefile                       |   1 +
> >>  arch/arm64/boot/dts/exynos/Makefile                |   5 +
> >>  arch/arm64/boot/dts/exynos/exynos7-espresso.dts    |  84 +++
> >>  arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi    | 588 +++++++++++++++++++++
> >>  arch/arm64/boot/dts/exynos/exynos7.dtsi            | 530 +++++++++++++++++++
> >>  arch/arm64/boot/dts/include/dt-bindings            |   1 +
> >>  arch/arm64/configs/defconfig                       |   4 +
> >>  9 files changed, 1231 insertions(+)
> >>  create mode 100644 arch/arm64/boot/dts/exynos/Makefile
> >>  create mode 100644 arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> >>  create mode 100644 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
> >>  create mode 100644 arch/arm64/boot/dts/exynos/exynos7.dtsi
> >>  create mode 120000 arch/arm64/boot/dts/include/dt-bindings
> >>
> >> --
> >> 2.1.0
> >>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
