From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 11 Apr 2017 18:09:59 +0200
Subject: [PATCH v4 1/7] pinctrl: dt-bindings: Add documentation for Armada
 37xx pin controllers
In-Reply-To: <20170410181514.kzbpkaxkwf7uycdc@rob-hp-laptop> (Rob Herring's
 message of "Mon, 10 Apr 2017 13:15:14 -0500")
References: <cover.65d0e6796fecf1fe6c5d07b981160b54dc9b4acd.1491405475.git-series.gregory.clement@free-electrons.com>
 <941d03c9a3bdfd5e789aada29b35184ec9fed9fe.1491405475.git-series.gregory.clement@free-electrons.com>
 <20170410181514.kzbpkaxkwf7uycdc@rob-hp-laptop>
Message-ID: <87inmbhqnc.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,
 
 On lun., avril 10 2017, Rob Herring <robh@kernel.org> wrote:

> On Wed, Apr 05, 2017 at 05:18:02PM +0200, Gregory CLEMENT wrote:

>> +Example:
>> +pinctrl_sb: pinctrl-sb at 18800 {
>
> Just pinctrl at ...
>
>> +	compatible = "marvell,armada3710-sb-pinctrl", "syscon", "simple-mfd";
>> +	reg = <0x18800 0x100>, <0x18C00 0x20>;
>> +	gpiosb: gpiosb {
>
> gpio {
>
> With that,
>
> Acked-by: Rob Herring <robh@kernel.org>

Could you do this change while applying the patches, or do you want a
new series?

Also, if the binding is also OK for you, do you agree that I apply the
last 2 patches on the mvebu trees? (of course with the same changes
asked by Rob)

Thanks,

Gregory



>
>
>> +		#gpio-cells = <2>;
>> +		gpio-ranges = <&pinctrl_sb 0 0 29>;
>> +		gpio-controller;
>> +		interrupts =
>> +		<GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
>> +		<GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
>> +		<GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
>> +		<GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
>> +		<GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
>> +	};
>> +
>> +	rgmii_pins: mii-pins {
>> +		groups = "rgmii";
>> +		function = "mii";
>> +	};
>> +
>> +};
>> -- 
>> git-series 0.9.1

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
