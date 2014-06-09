From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon,  9 Jun 2014 11:37:45 +0200
Subject: [PATCH 0/5] Add Maxim 77802 PMIC support
Message-ID: <1402306670-17041-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MAX77802 is a PMIC that contains 10 high efficiency Buck regulators,
32 Low-dropout (LDO) regulators, two 32kHz buffered clock outputs,
a Real-Time-Clock (RTC) and a I2C interface to program the individual
regulators, clocks and the RTC.

This series are based on drivers added by Simon Glass to the Chrome OS
kernel and adds support for the Maxim 77802 Power Management IC, their
regulators, clocks, RTC and I2C interface. It is composed of patches:

[PATCH 1/5] mfd: Add driver for Maxim 77802 Power Management IC
[PATCH 2/5] regulator: Add driver for Maxim 77802 PMIC regulators
[PATCH 3/5] clk: Add driver for Maxim 77802 PMIC clocks
[PATCH 4/5] rtc: Add driver for Maxim 77802 PMIC Real-Time-Clock
[PATCH 5/5] ARM: dts: Add max77802 device node for exynos5420-peach-pit

Patches 1-4 add support for the different devices and Patch 5 enables
the MAX77802 PMIC on the Exynos5420 based Peach pit board.

Lee,

Patches 2-4 depend on Patch 1 so I think that it makes sense if you take
1-4 through your mfd tree once the relevant maintainers ack the drivers
added to the other subsystems (regulator, clk and rtc).

Patch 5 can go through Kukjin tree since is just DTS changes.

Thanks a lot and best regards,
Javier

-- 
2.0.0.rc2
