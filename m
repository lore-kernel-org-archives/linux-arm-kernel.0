From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 26 Nov 2012 17:02:19 +0530
Subject: [GIT PULL]: spear-for-3.8 (was earlier: Re: [PATCH 00/14] ARM: SPEAr:
 DT updates)
Message-ID: <CAKohpokP60SXv02r8kETRLSf+RviFB8bgpO-VNvTfetQG4AtOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 November 2012 01:54, Olof Johansson <olof@lixom.net> wrote:

> We're also running out of time for 3.8 staging, but if you're able to
> figure out the above I'll make an attempt to apply the patches from above.

Hi Arnd/Olof,

To make things easy for you, i have a PULL request for you now :)

The following changes since commit 53d74fd79db19aae506de892273198b160c2ee95:

  Merge commit 'gpio-lw/devel' into spear-for-3.8 (2012-11-26 15:48:53 +0530)

are available in the git repository at:


  git://git.linaro.org/people/vireshk/linux.git spear-for-3.8

for you to fetch changes up to df1590d9ae5e37e07e7cf91107e4c2c946ce8bf4:

  ARM: SPEAr3xx: Shirq: Move shirq controller out of plat/ (2012-11-26
16:55:33 +0530)

----------------------------------------------------------------
Deepak Sikri (1):
      ARM: SPEAr: DT: Modify DT bindings for STMMAC

Shiraz Hashim (6):
      ARM: SPEAr13xx: DT: Add spics gpio controller nodes
      ARM: SPEAr: DT: Update device nodes
      ARM: SPEAr13xx: Remove fields not required for ssp controller
      ARM: SPEAr3xx: shirq: simplify and move the shared irq multiplexor to DT
      ARM: SPEAr3xx: DT: add shirq node for interrupt multiplexor
      ARM: SPEAr320: DT: Add SPEAr 320 HMI board support

Vipin Kumar (1):
      ARM: SPEAr: DT: Update partition info for MTD devices

Vipul Kumar Samar (5):
      ARM: SPEAr: DT: Update pinctrl list
      ARM: SPEAr: DT: Fix existing DT support
      ARM: SPEAr: DT: add uart state to fix warning
      ARM: SPEAr1310: Move 1310 specific misc register into machine
specific files
      ARM: SPEAr1310: Fix AUXDATA for compact flash controller

Viresh Kumar (1):
      ARM: SPEAr3xx: Shirq: Move shirq controller out of plat/

 .../devicetree/bindings/arm/spear/shirq.txt        |  48 ++++
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/spear1310-evb.dts                | 165 +++++++++--
 arch/arm/boot/dts/spear1310.dtsi                   |  32 ++-
 arch/arm/boot/dts/spear1340-evb.dts                | 253 +++++++++++++++--
 arch/arm/boot/dts/spear1340.dtsi                   |  61 ++++
 arch/arm/boot/dts/spear13xx.dtsi                   |  72 ++++-
 arch/arm/boot/dts/spear300-evb.dts                 |  20 +-
 arch/arm/boot/dts/spear300.dtsi                    |  14 +-
 arch/arm/boot/dts/spear310-evb.dts                 |  30 +-
 arch/arm/boot/dts/spear310.dtsi                    |  18 ++
 arch/arm/boot/dts/spear320-evb.dts                 |  35 ++-
 arch/arm/boot/dts/spear320-hmi.dts                 | 305 ++++++++++++++++++++
 arch/arm/boot/dts/spear320.dtsi                    |  39 ++-
 arch/arm/boot/dts/spear3xx.dtsi                    |   5 +-
 arch/arm/boot/dts/spear600-evb.dts                 |  46 ++-
 arch/arm/boot/dts/spear600.dtsi                    |  16 ++
 arch/arm/mach-spear13xx/include/mach/spear.h       |   8 -
 arch/arm/mach-spear13xx/spear1310.c                |  16 +-
 arch/arm/mach-spear13xx/spear13xx.c                |   2 -
 arch/arm/mach-spear3xx/include/mach/irqs.h         |  10 +-
 arch/arm/mach-spear3xx/spear300.c                  | 103 -------
 arch/arm/mach-spear3xx/spear310.c                  | 202 -------------
 arch/arm/mach-spear3xx/spear320.c                  | 205 +------------
 arch/arm/mach-spear3xx/spear3xx.c                  |   4 +
 arch/arm/plat-spear/Makefile                       |   2 +-
 arch/arm/plat-spear/shirq.c                        | 118 --------
 drivers/clk/spear/spear1310_clock.c                |   1 +
 drivers/irqchip/Makefile                           |   3 +-
 drivers/irqchip/spear-shirq.c                      | 316 +++++++++++++++++++++
 .../shirq.h => include/linux/irqchip/spear-shirq.h |  49 ++--
 31 files changed, 1426 insertions(+), 775 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/spear/shirq.txt
 create mode 100644 arch/arm/boot/dts/spear320-hmi.dts
 delete mode 100644 arch/arm/plat-spear/shirq.c
 create mode 100644 drivers/irqchip/spear-shirq.c
 rename arch/arm/plat-spear/include/plat/shirq.h =>
include/linux/irqchip/spear-shirq.h (60%)
