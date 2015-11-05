From: p.fedin@samsung.com (Pavel Fedin)
Date: Thu, 05 Nov 2015 14:14:19 +0300
Subject: [PATCH v5 4/4] ARM: dts: Add Ethernet chip to SMDK5410
In-Reply-To: <5639C1A5.1040708@samsung.com>
References: <cover.1446542020.git.p.fedin@samsung.com>
 <4568ad982f0af1846994119961cbb798edff311c.1446542020.git.p.fedin@samsung.com>
 <5639C1A5.1040708@samsung.com>
Message-ID: <004f01d117bb$1e4fbb40$5aef31c0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> > +	ethernet at 3 {
> > +		compatible = "smsc,lan9115";
> > +		reg = <3 0 0x10000>;
> > +		phy-mode = "mii";
> > +		interrupt-parent = <&gpx0>;
> > +		interrupts = <5 8>;
> 
> s/8/IRQ_TYPE_LEVEL_LOW/
> (is this really level low interrupt?)

 Yes, according to: https://github.com/AndreiLux/Perseus-S3/blob/master/arch/arm/mach-exynos/mach-smdk5250.c#L133

> Some other DTS include regulators: vddvario-supply and vdd33a-supply. It
> seems that they are not described in SMSC911x bindings but in
> GPMC-eth... but the smsc911x driver is requesting them. Could you
> investigate that? I think these regulators should be provided (and
> SMSC911x bindings should be updated).

 Sorry, i cannot. The board has lots of jumpers, which choose between fixed voltage and regulators for different components,
according to board's manual, but the manual is very poor IMHO, and i don't understand how to use them. And i use default,
fixed-voltage configuration.
 One of my colleagues tried to get it working, but failed. It actually requires more time, and IIRC you need to bring up i2c before
you can drive regulators.
 So can we leave it as it is for now? At least it works, and this is much better than no ethernet support at all.

> I don't have the board schematics so I couldn't verify the GPIOs.

 Me neither, i wrote GPIO settings according to chip datasheet i have. They are actually chip-specific, but i wrote them in board
file because on different boards you may use different banks, and therefore different pins. Or, if you don't use SROMc at all, you
can configure all pins to do something else.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
