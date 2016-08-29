From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Aug 2016 15:16:59 +0200
Subject: [PATCH 1/4 v2] soc: qcom: add EBI2 device tree bindings
In-Reply-To: <1472028758-29272-2-git-send-email-linus.walleij@linaro.org>
References: <1472028758-29272-1-git-send-email-linus.walleij@linaro.org>
 <1472028758-29272-2-git-send-email-linus.walleij@linaro.org>
Message-ID: <201608291516.59380.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 August 2016, Linus Walleij wrote:
> +
> +ebi2 at 1a100000 {
> +	compatible = "qcom,apq8060-ebi2";
> +	#address-cells = <2>;
> +	#size-cells = <1>;
> +	ranges = <0 0x0 0x1a800000 0x00800000>,
> +		 <1 0x0 0x1b000000 0x00800000>,
> +		 <2 0x0 0x1b800000 0x00800000>,
> +		 <3 0x0 0x1d000000 0x00800000>,
> +		 <4 0x0 0x1c800000 0x00800000>,
> +		 <5 0x0 0x1c000000 0x00800000>;
> +	reg = <0x1a100000 0x1000>, <0x1a110000 0x1000>;
> +	reg-names = "ebi2", "xmem";

...

> + 	foo-ebi2 at 1b800000 {
> +		compatible = "foo";
> +		reg = <2 0x1b800000 0x100>;
> +		(...)
> +	};
> +};

In this example, the addresses don't match: I assume the child
node should be listed as

	foo-ebi at 2,0 {
		reg = <2 0 0x100>;
	};

instead.

	Arnd
