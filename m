From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 14 Jun 2017 21:21:19 +0200
Subject: [GIT PULL] Allwinner clock fixes for 4.12
Message-ID: <20170614192119.xktlt4o5puje2pdu@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

Please pull the following patches for 4.12

Thanks!
Maxime

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-clk-fixes-for-4.12

for you to fetch changes up to d85da227c3ae43d9ca513d60f244213cb4e55485:

  clk: sunxi-ng: a64: Export PLL_PERIPH0 clock for the PRCM (2017-05-31 21:57:30 +0200)

----------------------------------------------------------------
Allwinner clock fixes for 4.12

Some fixes that fix some bindings that went in 4.12, fix a few reset and
clock offsets and a build error fix

----------------------------------------------------------------
Arnd Bergmann (1):
      clk: sunxi-ng: enable SUNXI_CCU_MP for PRCM

Chen-Yu Tsai (4):
      clk: sunxi-ng: a31: Correct lcd1-ch1 clock register offset
      dt-bindings: clock: sunxi-ccu: Add pll-periph to PRCM's needed clocks
      clk: sunxi-ng: h3: Export PLL_PERIPH0 clock for the PRCM
      clk: sunxi-ng: a64: Export PLL_PERIPH0 clock for the PRCM

Yong Deng (1):
      clk: sunxi-ng: v3s: Fix usb otg device reset bit

 Documentation/devicetree/bindings/clock/sunxi-ccu.txt | 7 ++++---
 drivers/clk/sunxi-ng/Kconfig                          | 1 +
 drivers/clk/sunxi-ng/ccu-sun50i-a64.h                 | 4 +++-
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c                  | 2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-h3.h                   | 4 +++-
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c                  | 2 +-
 include/dt-bindings/clock/sun50i-a64-ccu.h            | 2 ++
 include/dt-bindings/clock/sun8i-h3-ccu.h              | 2 ++
 8 files changed, 17 insertions(+), 7 deletions(-)

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170614/367a5621/attachment.sig>
