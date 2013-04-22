From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Apr 2013 13:44:00 +0200
Subject: [PATCH 06/23] ARM: u300: basic device tree support
In-Reply-To: <1366624340-6293-1-git-send-email-linus.walleij@stericsson.com>
References: <1366624340-6293-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <201304221344.00422.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 22 April 2013, Linus Walleij wrote:
> +/ {

We don't really care about the device node names in Linux, but please use the
common ones, without any trailing digits:

> +	timer: timer0 at c0014000 {
> +		compatible = "stericsson,u300-apptimer";
> +		reg = <0xc0014000 0x1000>;
> +		interrupt-parent = <&vica>;
> +		interrupts = <24 25 26 27>;
> +	};

timer at c0014000

> +
> +	gpio: gpio0 at c0016000 {
> +		compatible = "stericsson,gpio-coh901";
> +		reg = <0xc0016000 0x1000>;


gpio at c0016000

> +	pinctrl: pinctrl0 at c0011000 {
> +		compatible = "stericsson,pinctrl-u300";
> +		reg = <0xc0011000 0x1000>;
> +	};

pinctrl at c0011000

> +		vica: intc at 0xa0001000 {
> +			compatible = "arm,versatile-vic";
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			reg = <0xa0001000 0x20>;
> +		};

interrupt-controller at a0001000

Note also the erroneous 0x part you have in the name here.

> +		uart0: uart at c0013000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0xc0013000 0x1000>;
> +			interrupt-parent = <&vica>;
> +			interrupts = <22>;
> +		};

serial at c0013000

	Arnd
