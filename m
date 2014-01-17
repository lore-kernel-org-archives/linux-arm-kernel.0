From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Jan 2014 21:06:55 +0100
Subject: [PATCH v4 8/8] ARM: brcmstb: dts: add a reference DTS for
 Broadcom 7445
In-Reply-To: <1389986367-4010-9-git-send-email-marc.ceeeee@gmail.com>
References: <1389986367-4010-1-git-send-email-marc.ceeeee@gmail.com>
 <1389986367-4010-9-git-send-email-marc.ceeeee@gmail.com>
Message-ID: <201401172106.55668.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 17 January 2014, Marc Carino wrote:
> +       serial at f0406b00 {
> +               compatible = "ns16550a";
> +               reg = <0x00 0xf0406b00 0x00 0x20>;
> +               reg-shift = <2>;
> +               reg-io-width = <4>;
> +               interrupts = <0 75 0x4>;
> +               clock-frequency = <0x4d3f640>;
> +       };
> +
> +       rdb {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "simple-bus";
> +               ranges = <0 0x00 0xf0000000 0x1000000>;
> +
> +               sun_top_ctrl: syscon at 404000 {
> +                       compatible = "brcm,bcm7445-sun-top-ctrl",
> +                                    "syscon";
> +                       reg = <0x404000 0x51c>;
> +               };
> +

Yes, this looks better, but as a minor comment, the serial device above
should really be part of the rdb bus now, since that encompasses the
0xf0000000 device range.

	Arnd
