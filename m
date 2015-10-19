From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 19 Oct 2015 14:00:31 +0900
Subject: [PATCH 0/3] ARM: dts: Enable Exynos RNG module
Message-ID: <1445230834-32689-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


The patchset adds necessary clock from Security SubSystem (SSS)
and enables the PRNG module of Exynos for Trats2 board.

The first patch (clock) is required for other ones so please
take everything in one step.

The actual Device Tree support (and compatible) was sent in separate
patch:
 - https://patchwork.kernel.org/patch/7432891/
 - http://marc.info/?l=linux-crypto-vger&m=144522952725052&w=2

The device can be tested (after applying both patchsets) with:
$ echo exynos > /sys/class/misc/hw_random/rng_current
$ dd if=/dev/hwrng of=/dev/null bs=1 count=16


Best regards,
Krzysztof

Krzysztof Kozlowski (3):
  clk: samsung: exynos4: Add SSS gate clock
  ARM: dts: Add PRNG module for exynos4
  ARM: dts: Enable PRNG module on exynos4412-trats2

 arch/arm/boot/dts/exynos4.dtsi          | 8 ++++++++
 arch/arm/boot/dts/exynos4412-trats2.dts | 4 ++++
 drivers/clk/samsung/clk-exynos4.c       | 1 +
 include/dt-bindings/clock/exynos4.h     | 1 +
 4 files changed, 14 insertions(+)

-- 
1.9.1
