From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 24 Aug 2017 10:36:20 +0200
Subject: [GIT PULL] Allwinner clock changes for 4.14, take 3
Message-ID: <20170824083620.b5cq4qtyr3cqtpjx@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is a quite late PR, but this also something we've been waiting
for for quite some time already.

These patches convert our last users of the old clock framework to the
new one. We still have some marginal users of the old clock drivers,
but they shouldn't prevent the fix for the orphans clocks we hold back
to work.

Maxime

The following changes since commit cd030a78f7aa06fe216f6665a6ea84b8f3e5b3d3:

  clk: sunxi-ng: support R40 SoC (2017-08-19 17:04:37 +0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-clk-for-4.14-3

for you to fetch changes up to c84f5683f6e9fee78e054431d89121225ccb7464:

  clk: sunxi-ng: Add sun4i/sun7i CCU driver (2017-08-24 10:15:54 +0200)

----------------------------------------------------------------
Allwinner clock changes for 4.14, part 3

Conversion of the last two SoCs (A10, A20) to the sunxi-ng framework.

----------------------------------------------------------------
Priit Laes (3):
      dt-bindings: List devicetree binding for the CCU of Allwinner A20
      dt-bindings: List devicetree binding for the CCU of Allwinner A10
      clk: sunxi-ng: Add sun4i/sun7i CCU driver

 .../devicetree/bindings/clock/sunxi-ccu.txt        |    2 +
 drivers/clk/sunxi-ng/Kconfig                       |   13 +
 drivers/clk/sunxi-ng/Makefile                      |    1 +
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c               | 1456 ++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun4i-a10.h               |   61 +
 include/dt-bindings/clock/sun4i-a10-ccu.h          |  200 +++
 include/dt-bindings/clock/sun7i-a20-ccu.h          |   53 +
 include/dt-bindings/reset/sun4i-a10-ccu.h          |   69 +
 8 files changed, 1855 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun4i-a10.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun4i-a10.h
 create mode 100644 include/dt-bindings/clock/sun4i-a10-ccu.h
 create mode 100644 include/dt-bindings/clock/sun7i-a20-ccu.h
 create mode 100644 include/dt-bindings/reset/sun4i-a10-ccu.h

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170824/d074719f/attachment.sig>
