From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 26 Apr 2015 22:31:01 +0800
Subject: [PATCH 00/11] ARM: imx: move clock drivers into drivers/clk
Message-ID: <1430058672-9267-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series cleans up i.MX clock drivers to remove all the inclusions
of platform headers, and then move them into drivers/clk/imx/ folder.

Mike, Stephen,

I would like to take this series through IMX tree.  So please give your
ACKs if it looks fine to you.  Thanks.

Shawn

Shawn Guo (11):
  ARM: imx: use dynamic mapping for timer
  ARM: imx: use dynamic mapping for CCM
  ARM: imx: move revision definitions and declarations into a header
  ARM: imx5: let pm code map CCM block on its own
  ARM: imx6: set initial power mode in pm function
  ARM: imx6: let pm code map CCM block on its own
  ARM: imx6: do not use cpu_is_xxx() in clock driver
  ARM: imx: add clk-pllv1 type support
  ARM: imx: remove inclusions of platform headers
  ARM: imx: move clock drivers into drivers/clk
  MAINTAINERS: add new folders into IMX entry

 MAINTAINERS                                        |  2 ++
 arch/arm/mach-imx/Makefile                         | 27 +++++++---------
 arch/arm/mach-imx/common.h                         | 11 ++-----
 arch/arm/mach-imx/cpuidle-imx6q.c                  |  4 +--
 arch/arm/mach-imx/cpuidle-imx6sl.c                 |  4 +--
 arch/arm/mach-imx/cpuidle-imx6sx.c                 |  4 +--
 arch/arm/mach-imx/hardware.h                       |  1 +
 arch/arm/mach-imx/mx27.h                           |  4 ---
 arch/arm/mach-imx/mx3x.h                           |  7 ----
 arch/arm/mach-imx/mxc.h                            | 16 ----------
 arch/arm/mach-imx/pm-imx5.c                        |  9 +++---
 arch/arm/mach-imx/pm-imx6.c                        | 30 ++++++++++--------
 arch/arm/mach-imx/time.c                           |  5 +--
 drivers/clk/Makefile                               |  1 +
 drivers/clk/imx/Makefile                           | 25 +++++++++++++++
 {arch/arm/mach-imx => drivers/clk/imx}/clk-busy.c  |  0
 {arch/arm/mach-imx => drivers/clk/imx}/clk-cpu.c   |  0
 .../mach-imx => drivers/clk/imx}/clk-fixup-div.c   |  0
 .../mach-imx => drivers/clk/imx}/clk-fixup-mux.c   |  0
 .../clk/imx}/clk-gate-exclusive.c                  |  0
 {arch/arm/mach-imx => drivers/clk/imx}/clk-gate2.c |  0
 {arch/arm/mach-imx => drivers/clk/imx}/clk-imx1.c  | 16 ++++++----
 {arch/arm/mach-imx => drivers/clk/imx}/clk-imx21.c | 13 +++++---
 {arch/arm/mach-imx => drivers/clk/imx}/clk-imx25.c |  6 ++--
 {arch/arm/mach-imx => drivers/clk/imx}/clk-imx27.c | 14 +++++---
 {arch/arm/mach-imx => drivers/clk/imx}/clk-imx31.c | 34 ++++++++++++++------
 {arch/arm/mach-imx => drivers/clk/imx}/clk-imx35.c | 31 ++++++++++++++----
 .../mach-imx => drivers/clk/imx}/clk-imx51-imx53.c |  5 +--
 {arch/arm/mach-imx => drivers/clk/imx}/clk-imx6q.c | 34 +++++++++++---------
 .../arm/mach-imx => drivers/clk/imx}/clk-imx6sl.c  |  7 ----
 .../arm/mach-imx => drivers/clk/imx}/clk-imx6sx.c  |  6 ----
 {arch/arm/mach-imx => drivers/clk/imx}/clk-pfd.c   |  0
 {arch/arm/mach-imx => drivers/clk/imx}/clk-pllv1.c | 33 +++++++++++++------
 {arch/arm/mach-imx => drivers/clk/imx}/clk-pllv2.c |  0
 {arch/arm/mach-imx => drivers/clk/imx}/clk-pllv3.c |  0
 {arch/arm/mach-imx => drivers/clk/imx}/clk-vf610.c |  0
 {arch/arm/mach-imx => drivers/clk/imx}/clk.c       |  0
 {arch/arm/mach-imx => drivers/clk/imx}/clk.h       | 20 ++++++++++--
 include/soc/imx/revision.h                         | 37 ++++++++++++++++++++++
 39 files changed, 249 insertions(+), 157 deletions(-)
 create mode 100644 drivers/clk/imx/Makefile
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-busy.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-cpu.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-fixup-div.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-fixup-mux.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-gate-exclusive.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-gate2.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx1.c (92%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx21.c (96%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx25.c (98%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx27.c (97%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx31.c (92%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx35.c (94%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx51-imx53.c (99%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx6q.c (98%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx6sl.c (99%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx6sx.c (99%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-pfd.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-pllv1.c (75%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-pllv2.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-pllv3.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-vf610.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk.h (89%)
 create mode 100644 include/soc/imx/revision.h

-- 
1.9.1
