From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 30 Mar 2017 18:18:08 +0200
Subject: [PATCH v3 1/7] pinctrl: dt-bindings: Add documentation for Armada
 37xx pin controllers
In-Reply-To: <20170329211105.ype3os6jldsjyrqa@rob-hp-laptop> (Rob Herring's
 message of "Wed, 29 Mar 2017 16:11:05 -0500")
References: <cover.72ded2a212a37139db2a4193482b04a84a545a48.1490282185.git-series.gregory.clement@free-electrons.com>
 <941d03c9a3bdfd5e789aada29b35184ec9fed9fe.1490282185.git-series.gregory.clement@free-electrons.com>
 <20170329211105.ype3os6jldsjyrqa@rob-hp-laptop>
Message-ID: <87d1cy91rz.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,
 
 On mer., mars 29 2017, Rob Herring <robh@kernel.org> wrote:

>> +GPIO subnode:
>> +
>> +Please refer to gpio.txt in this directory for details of gpio-ranges property
>> +and the common GPIO bindings used by client devices.
>> +
>> +Required properties for gpio driver under the gpio subnode:
>
> Why does this need to be a sub node? You should probably have a 
> compatible if it is.

It is needed to be able to have a phandle associated to the gpio. Then
the other node can refer to it.

But if we can do without it I would happy to do it.


>
>> +- interrupts: List of interrupt specifier for the controllers interrupt.
>> +- gpio-controller: Marks the device node as a gpio controller.
>> +- #gpio-cells: Should be 2. The first cell is the GPIO number and the
>> +   second cell specifies GPIO flags, as defined in
>> +   <dt-bindings/gpio/gpio.h>. Only the GPIO_ACTIVE_HIGH and
>> +   GPIO_ACTIVE_LOW flags are supported.
>> +- gpio-ranges: Range of pins managed by the GPIO controller.
>> +
>> +Xtal Clock bindings for Marvell Armada 37xx SoCs
>> +------------------------------------------------
>> +
>> +see Documentation/devicetree/bindings/clock/armada3700-xtal-clock.txt
>> +
>> +
>> +Example:
>> +pinctrl_sb: pinctrl-sb at 18800 {
>
> pinctrl@

OK

>
>> +	compatible = "marvell,armada3710-sb-pinctrl", "syscon", "simple-mfd";
>> +	reg = <0x18800 0x100>, <0x18C00 0x20>;
>> +	gpiosb: gpiosb {
>
> gpio@

There is no reg property so we don't use the @

Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
