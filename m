From: b.galvani@gmail.com (Beniamino Galvani)
Date: Sat, 21 Jun 2014 16:22:05 +0200
Subject: [PATCH v2 0/3] Add Rockchip Soc PWM driver
Message-ID: <1403360528-12757-1-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the PWM controller found on Rockchip
RK29, RK30 and RK31 SoCs. It is based on the documentation publicly
available [0] and kernel sources from Rockchip [1] and has been tested
on RK3188.

The last patch, which adds device tree nodes in the dts, depends on
the clocks introduced by Heiko in his recent submission of a new clk
driver for Rockchip RK3188.

[0] http://dl.radxa.com/rock/docs/hw/ds/Rockchip%20RK30xx%20TRM%20V2.0.pdf
[1] https://github.com/rkchrome/kernel

Changes in v2:
  * address comments from Thierry Reding:
    - remove dependency on OF
    - use NSEC_PER_SEC from time.h
    - fix MODULE_DEVICE_TABLE name
    - make pwm_ops struct const
    - indentation and cosmetics

Beniamino Galvani (3):
  pwm: add Rockchip SoC PWM support
  pwm: rockchip: document device tree bindings
  ARM: dts: rk3xxx: add PWM nodes

 .../devicetree/bindings/pwm/pwm-rockchip.txt       |   17 ++
 arch/arm/boot/dts/rk3188.dtsi                      |   40 +++++
 arch/arm/boot/dts/rk3xxx.dtsi                      |   32 ++++
 drivers/pwm/Kconfig                                |    7 +
 drivers/pwm/Makefile                               |    1 +
 drivers/pwm/pwm-rockchip.c                         |  177 ++++++++++++++++++++
 6 files changed, 274 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
 create mode 100644 drivers/pwm/pwm-rockchip.c

-- 
1.7.10.4
