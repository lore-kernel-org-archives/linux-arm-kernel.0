From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 17 Aug 2013 21:28:34 +0200
Subject: [RFC v1 4/5] ARM: mvebu: add Armada 1500 and Sony NSZ-GS7 device
 tree files
In-Reply-To: <1376682098-10580-5-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376682098-10580-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376682098-10580-5-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <201308172128.35245.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 August 2013, Sebastian Hesselbarth wrote:
> +               cpu at 0 {
> +                       compatible = "marvell,sheeva-v7";
> +                       device_type = "cpu";
> +                       next-level-cache = <&l2>;
> +                       reg = <0>;
> +               };
...
> +               l2: l2-cache-controller at 1ac0000 {
> +                       compatible = "marvell,aurora-outer-cache";
> +                       reg = <0x1ac0000 0x1000>;
> +                       cache-level = <2>;
> +               };
> +
> +               gic: interrupt-controller at 1ad0000 {
> +                       compatible = "arm,cortex-a9-gic";
> +                       reg = <0x1ad1000 0x1000
> +                              0x1ad0100 0x0100>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <3>;
> +               };
> +
> +               local-timer at 1ad0600 {
> +                       compatible = "arm,cortex-a9-twd-timer";
> +                       reg = <0x1ad0600 0x20>;
> +                       interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&cpu0clk>;
> +               };

This seems like a strange combination. I would have expected either PJ4+Aurora+apbtimer
or A9+pl310+localtimer, based on what I found in the chromecast kernel source.
Do you have more information here about what is used on the two variants?

	Arnd
