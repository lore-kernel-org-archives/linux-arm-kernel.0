From: jm@lentin.co.uk (Jamie Lentin)
Date: Mon, 10 Sep 2012 14:51:50 +0100
Subject: [PATCH V2 0/2] hwmon: kirkwood: Add DT bindings to gpio-fan for
 DNS-32[05]
In-Reply-To: <1347035675-23907-1-git-send-email-jm@lentin.co.uk>
References: <1347035675-23907-1-git-send-email-jm@lentin.co.uk>
Message-ID: <1347285112-13542-1-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks to Guenter & Andrew---all the feedback made sense, and hopefully
this patchset addresses everything.

This is an attempt at getting DT support into gpio-fan, in a similar
fashion to gpio-leds and gpio-keys. I guess the most contentious bit is
going to be the bindings.

Tested on a D-Link DNS-320.

Changes since V1:-

* Don't hide return codes [Guenter Roeck]
* Remove typecast noise [Guenter Roeck]
* Use of_find_property instead of counting u32s [Guenter Roeck]
* Don't count GPIOs twice [Andrew Lunn]
* Use of_prop_next_u32 to get records in a more obvious fashion
* Use CONFIG_OF_GPIO instead of CONFIG_OF
* Apply __devinitdata to of_gpio_fan_match [Andrew Lunn]

* Remove useless gpio-fan.h [Andrew Lunn]

Feedback appreciated!

Jamie Lentin (2):
  hwmon: Add devicetree bindings to gpio-fan
  ARM: kirkwood: Use devicetree to define DNS-32[05] fan

 .../devicetree/bindings/gpio/gpio-fan.txt          |   25 +++++
 arch/arm/boot/dts/kirkwood-dnskw.dtsi              |   10 ++
 arch/arm/mach-kirkwood/board-dnskw.c               |   26 -----
 drivers/hwmon/gpio-fan.c                           |  116 ++++++++++++++++++++
 4 files changed, 151 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-fan.txt

-- 
1.7.10.4
