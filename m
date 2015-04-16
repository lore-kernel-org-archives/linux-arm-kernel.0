From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Apr 2015 11:44:49 +0200
Subject: [PATCH 3/4] ARM: dts: UniPhier: add support for UniPhier SoCs and
 boards
In-Reply-To: <1429170038-16757-4-git-send-email-yamada.masahiro@socionext.com>
References: <1429170038-16757-1-git-send-email-yamada.masahiro@socionext.com>
 <1429170038-16757-4-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <2204571.AOVr95oO32@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 April 2015 16:40:37 Masahiro Yamada wrote:
> +
> +/ {
> +	model = "UniPhier PH1-LD4 Reference Board";
> +	compatible = "socionext,ph1-ld4-ref", "socionext,ph1-ld4";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x80000000 0x20000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200 earlyprintk";
> +	};

I would remove the 'earlyprintk' option here. You don't add any options
for the platform in Kconfig.debug, and I hope that we can eventually
start using earlycon. Please add an appropriate stdio-path property
here, but note that we are still lacking the fixmap patches to make
earlycon work.

Otherwise looks good.

	Arnd
