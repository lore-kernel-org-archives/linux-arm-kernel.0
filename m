From: djw@t-chip.com.cn (djw at t-chip.com.cn)
Date: Tue,  8 May 2018 10:48:22 +0800
Subject: [PATCH v0 0/2] Add sdmmc UHS support to ROC-RK3328-CC board
Message-ID: <1525747704-8537-1-git-send-email-djw@t-chip.com.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Levin Du <djw@t-chip.com.cn>

Hi all,

This is an attemp to add sdmmc UHS support to the ROC-RK3328-CC board.

It adds a new compatible `rockchip,rk3328-gpio-syscon10` to the gpio-syscon
driver,  so that a new gpio controller named `gpio_syscon10` can be defined
and used in the regulator-gpio. This regulator controls the signal voltage of the
sdmmc. It is essential for UHS support which requires 1.8V signal voltage.


Levin Du (2):
  gpio: syscon: Add gpio-syscon for rk3328
  arm64: dts: rockchip: Add sdmmc UHS support for roc-rk3328-cc

 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts | 36 ++++++++++++++++++++++++++
 drivers/gpio/gpio-syscon.c                     | 32 +++++++++++++++++++++++
 2 files changed, 68 insertions(+)

-- 
2.7.4
