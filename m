From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Mon,  6 Nov 2017 12:38:12 +0530
Subject: [PATCH v2 0/4] arm64: defconfig: enable additional led triggers
Message-ID: <cover.1509951550.git.amit.kucheria@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset enables the kernel panic and disk-activity trigger for LEDs
and then enables the panic trigger for three 96Boards - DB410c, Hikey and
Hikey960.

DB410c and Hikey panic behaviour has been tested by triggering a panic
through /proc/sysrq-trigger, while Hikey960 is only compile-tested.


Amit Kucheria (4):
  arm64: defconfig: enable new trigger modes for leds
  arm64: dts: qcom: apq8016-sbc: Allow USR4 LED to notify kernel panic
  arm64: dts: hisilicon: hi6220-hikey: Allow USR1 LED to notify kernel
    panic
  arm64: dts: hisilicon: hi3660-hikey960: Allow USR4 LED to notify
    kernel panic

 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 1 +
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts    | 1 +
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi         | 1 +
 arch/arm64/configs/defconfig                      | 2 ++
 4 files changed, 5 insertions(+)

-- 
2.7.4
