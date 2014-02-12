From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Feb 2014 14:12:27 +0100
Subject: [PATCH v2 05/10] ARM: mvebu: add Device Tree for the Armada 375
 DB board
In-Reply-To: <1392200619-3141-6-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392200619-3141-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1392200619-3141-6-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <2335694.A7tsOBXSlH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 February 2014 11:23:34 Thomas Petazzoni wrote:
> +                       i2c0: i2c at 11000 {
> +                               status = "okay";
> +                               clock-frequency = <100000>;
> +                               pinctrl-0 = <&i2c0_pins>;
> +                               pinctrl-names = "default";
> +                       };
> +
> +                       i2c1: i2c at 11100 {
> +                               status = "okay";
> +                               clock-frequency = <100000>;
> +                               pinctrl-0 = <&i2c1_pins>;
> +                               pinctrl-names = "default";
> +                       };

I think you should either use the label to reference the node here,
or omit it in the board.dts file. There is no point in defining
multiple identical labels.

	Arnd
