From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 5 Jan 2018 21:11:35 +0100 (CET)
Subject: [Bug] Endless deferred probe of dwc2 on RPi 3
Message-ID: <1098363332.45288.1515183095677@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
i noticed on my Raspberry Pi 3 (Linux 4.15rc6, ARM64, defconfig) that probing of dwc2 driver is deferred endlessly. This issue is triggered by a recent DT clean up 014d6da6cb25 ("ARM: dts: bcm283x: Fix DTC warnings about missing phy-cells") which is correct according to Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt

Here is the call stack which always returns -EPROBE_DEFER on this platform:
dwc2_lowlevel_hw_init()
devm_phy_get()
phy_get()
_of_phy_get()

Btw Raspberry Pi 2 (ARM, multi_v7_defconfig) is also affected, but not Raspberry Pi Zero W (ARM, bcm2835_config) while all 3 platforms share the same USB DT nodes.

Any ideas to fix this issue are welcome.

Best regards
Stefan
