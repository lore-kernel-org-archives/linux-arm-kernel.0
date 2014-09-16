From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Tue, 16 Sep 2014 15:03:16 +0530
Subject: [PATCH 0/2] i2c: Add i2c support for Exynos7 SoC
Message-ID: <1410859998-29285-1-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds code to the i2c-exynos5.c driver to support
the HSI2C H/W available on Exynos7 SoC.

Also, modifies the Kconfig dependencies to be able to select
for ARCH_EXYNOS7 platform.

The following patches are tested based on Kgene's for-next tree.
https://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/log/?h=for-next

Following patches are required for this series:
1. "tty/serial: fix config dependencies for samsung serial"
   https://www.mail-archive.com/linux-samsung-soc <at> vger.kernel.org/msg36208.html
2. "dts, kbuild: Implement support for dtb vendor subdirs" patchset 
   http://comments.gmane.org/gmane.linux.kbuild.devel/12131
3. [PATCH v4 0/8] arch: arm64: enable support for Samsung Exynos7 SoC
   http://www.spinics.net/lists/devicetree/msg49130.html
4. [PATCH 0/4] Add initial support for pinctrl on Exynos7
   http://www.spinics.net/lists/devicetree/msg49237.html

Naveen Krishna Chatradhi (2):
  i2c: exynos: add support for HSI2C module on Exynos7
  i2c: exynos5: Add Kconfig dependencies

 .../devicetree/bindings/i2c/i2c-exynos5.txt        |    2 +
 drivers/i2c/busses/Kconfig                         |    2 +-
 drivers/i2c/busses/i2c-exynos5.c                   |   71 ++++++++++++++++++--
 3 files changed, 68 insertions(+), 7 deletions(-)

-- 
1.7.9.5
