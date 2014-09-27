From: olof@lixom.net (Olof Johansson)
Date: Sat, 27 Sep 2014 12:52:57 -0700
Subject: [GIT PULL] ARM: SoC fixes for 3.17
Message-ID: <20140927195257.GA19065@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 2ce7598c9a453e0acd0e07be7be3f5eb39608ebd:

  Linux 3.17-rc4 (2014-09-07 16:09:43 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to fa9eb3241895d2771b87f20dd23b40de664c5e4e:

  drivers/soc: qcom: do not disable the iface clock in probe (2014-09-23 21:38:32 -0700)

----------------------------------------------------------------
ARM: SoC fixes for 3.17

Here's our last set of fixes for 3.17. Most of these are for TI platforms,
fixing some noisy Kconfig issues, runtime clock and power issues on
several platforms and NAND timings on DRA7.

There are also a couple of bug fixes for i.MX, one for QCOM and a small
fix to avoid section mismatch noise on PXA.

Diffstat looks large, partially due to some tables being updated and
thus touching many lines. The qcom gsbi change also restructures clock
management a bit and thus touches a bunch of lines.

All in all, a bit more changes than we'd like at this point, but nothing
stands out as risky either so it seems like the right thing to send it
up now instead of holding it to the merge window.

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: pxa: fix section mismatch warning for pxa_timer_nodt_init

Dmitry Lifshitz (1):
      ARM: dts: cm-t54: fix serial console power supply.

Markus Niebel (1):
      ARM: DT: imx53: fix lvds channel 1 port

Murali Karicheri (1):
      ARM: keystone: dts: fix bindings for pcie and usb clock nodes

Nishanth Menon (1):
      bus: omap_l3_noc: Fix connID for OMAP4

Olof Johansson (3):
      Merge tag 'fixes-v3.17-rc4' of git://git.kernel.org/.../ssantosh/linux-keystone into fixes
      Merge tag 'fixes-v3.17-rc4' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'fix-v3.17-io-chain-v3' of git://git.kernel.org/.../tmlind/linux-omap into fixes

Roger Quadros (1):
      ARM: dts: dra7-evm: Fix NAND GPMC timings

Shawn Guo (1):
      ARM: imx: fix .is_enabled() of shared gate clock

Srinivas Kandagatla (1):
      drivers/soc: qcom: do not disable the iface clock in probe

Tony Lindgren (2):
      ARM: OMAP: Fix Kconfig warning for omap1
      ARM: OMAP3: Fix I/O chain clock line assertion timed out error

 .../devicetree/bindings/staging/imx-drm/ldb.txt    | 15 ++++++-
 arch/arm/boot/dts/dra7-evm.dts                     | 27 ++++++------
 arch/arm/boot/dts/imx53.dtsi                       | 12 +++++-
 arch/arm/boot/dts/k2e-clocks.dtsi                  |  6 +--
 arch/arm/boot/dts/omap5-cm-t54.dts                 |  5 +--
 arch/arm/mach-imx/clk-gate2.c                      |  6 +--
 arch/arm/mach-omap2/Kconfig                        |  3 --
 arch/arm/mach-omap2/omap_hwmod.c                   |  2 +-
 arch/arm/mach-omap2/prm3xxx.c                      | 39 +++++++++++++++--
 arch/arm/mach-pxa/generic.c                        |  2 +-
 arch/arm/plat-omap/Kconfig                         |  3 ++
 drivers/bus/omap_l3_noc.h                          | 50 +++++++++++-----------
 drivers/soc/qcom/qcom_gsbi.c                       | 46 ++++++++++++++------
 13 files changed, 139 insertions(+), 77 deletions(-)
