From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 04 Jul 2016 17:33:32 +0200
Subject: [GIT PULL] Reset controller changes for v4.8, part 3
Message-ID: <1467646412.2224.28.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

Please consider merging this tag with two new drivers for the Hisilicon
hi6220 media reset controller and for various TI SYSCON based reset
controllers. Lee's API changes are already merged into v4.7-rc6 as part
of commit 4aa34ce3c1ee ("Merge tag 'mfd-fixes-4.7' of
git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd").
Let me know if I should drop them here.

regards
Philipp

The following changes since commit 79795e20a184ebabf4ae743d1506cc39783caa46:

  dt-bindings: reset: Add bindings for the Meson SoC Reset Controller (2016-06-01 08:21:12 +0200)

are available in the git repository at:

  git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.8-3

for you to fetch changes up to af3e1629c8d0d26627f3dcc237a6facda8bb1090:

  Merge branch 'reset/explicit-api' into reset/next (2016-06-29 23:39:52 +0200)

----------------------------------------------------------------
Reset controller changes for v4.8, part 3

- change request API to be more explicit about the difference between
  exclusive and shared resets (the former guarantee the reset line is
  asserted immediately when reset_control_assert is called, the latter
  are refcounted and do not guarantee this).
- add Hisilicon hi6220 media subsystem reset controller support
- add TI SYSCON based reset controller support

----------------------------------------------------------------
Andrew F. Davis (2):
      Documentation: dt: reset: Add TI syscon reset binding
      reset: add TI SYSCON based reset driver

Chen Feng (1):
      reset: hisilicon: Change to syscon register access

Lee Jones (5):
      reset: Reorder inline reset_control_get*() wrappers
      reset: Ensure drivers are explicit when requesting reset lines
      reset: Supply *_shared variant calls when using of_* API
      reset: Supply *_shared variant calls when using *_optional APIs
      reset: TRIVIAL: Add line break at same place for similar APIs

Philipp Zabel (1):
      Merge branch 'reset/explicit-api' into reset/next

Xinliang Liu (3):
      reset: hisilicon: Add media reset controller binding
      arm64: dts: hi6220: Add media subsystem reset dts
      reset: hisilicon: Add hi6220 media subsystem reset support

 .../bindings/reset/hisilicon,hi6220-reset.txt      |   4 +-
 .../devicetree/bindings/reset/ti-syscon-reset.txt  |  91 ++++++++
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |   2 +
 drivers/reset/Kconfig                              |  10 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/hisilicon/hi6220_reset.c             | 122 +++++++----
 drivers/reset/reset-ti-syscon.c                    | 237 +++++++++++++++++++++
 include/dt-bindings/reset/hisi,hi6220-resets.h     |   8 +
 include/dt-bindings/reset/ti-syscon.h              |  38 ++++
 include/linux/reset.h                              | 211 ++++++++++++++----
 10 files changed, 643 insertions(+), 81 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/ti-syscon-reset.txt
 create mode 100644 drivers/reset/reset-ti-syscon.c
 create mode 100644 include/dt-bindings/reset/ti-syscon.h
