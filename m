From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 16 Jul 2015 10:25:37 +0200
Subject: [PATCH v3 1/3] leds: netxbig: add device tree binding
In-Reply-To: <20150623211711.GF4853@kw.sim.vm.gnt>
References: <1434639590-27389-1-git-send-email-simon.guinot@sequanux.org>
 <1434639590-27389-2-git-send-email-simon.guinot@sequanux.org>
 <55894D0A.8000306@samsung.com>
 <20150623211711.GF4853@kw.sim.vm.gnt>
Message-ID: <CACRpkdZvbgZWjCOPsPeojBpsPjt+WF_rgQWG_biEqphuErR1dQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 23, 2015 at 11:17 PM, Simon Guinot
<simon.guinot@sequanux.org> wrote:
> On Tue, Jun 23, 2015 at 02:11:54PM +0200, Jacek Anaszewski wrote:

>> >+Binding for the GPIO extension bus found on some LaCie/Seagate boards
>> >+(Example: 2Big/5Big Network v2, 2Big NAS).
>> >+
>> >+Required properties:
>> >+- compatible: "lacie,netxbig-gpio-ext".
>> >+- addr-gpios: GPIOs representing the address register.
>> >+- data-gpios: GPIOs representing the data register.
>> >+- enable-gpio: GPIO used to enable the new configuration (address, data).
(...)
>> >+Example:
>> >+
>> >+netxbig_gpio_ext: netxbig-gpio-ext {
>> >+    compatible = "lacie,netxbig-gpio-ext";
>> >+
>> >+    addr-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH
>> >+                  &gpio1 16 GPIO_ACTIVE_HIGH
>> >+                  &gpio1 17 GPIO_ACTIVE_HIGH>;
>> >+    data-gpios = <&gpio1 12 GPIO_ACTIVE_HIGH
>> >+                  &gpio1 13 GPIO_ACTIVE_HIGH
>> >+                  &gpio1 14 GPIO_ACTIVE_HIGH>;
(..)
>> >+    enable-gpio = <&gpio0 29 GPIO_ACTIVE_HIGH>;
>> >+};
>>
>> This needs gpio maintainer ack. Adding Linus and Alexandre.

Looks pretty straight-forward, a lot of GPIOs for LEDs, well such is life.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
