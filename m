From: yoann@printk.fr (Yoann Sculo)
Date: Fri, 6 Nov 2015 17:05:55 +0100
Subject: [PATCH 3/4] ARM: dts: kirkwood: add Seagate GoFlex Home
In-Reply-To: <00000150d49a8745-1c2bc8d4-1333-46bb-bf0e-5508ef988c73-000000@email.amazonses.com>
References: <1446675888-24495-1-git-send-email-luka.perkov@sartura.hr>
 <00000150d49a8745-1c2bc8d4-1333-46bb-bf0e-5508ef988c73-000000@email.amazonses.com>
Message-ID: <563CCFE3.7080603@printk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Luka,

I tested your patch on the GoFlex Home.

> +	gpio-leds {
> +		compatible = "gpio-leds";
> +
> +		health {
> +			label = "status:green:health";
> +			gpios = <&gpio1 14 1>;
> +			linux,default-trigger = "default-on";
> +		};
> +		fault {
> +			label = "status:orange:fault";
> +			gpios = <&gpio1 15 1>;
> +		};
> +		misc {
> +			label = "status:white:misc";
> +			gpios = <&gpio1 8 1>;
> +			linux,default-trigger = "ide-disk";
> +		};
> +	};

I noticed green and orange leds were working fine (0 == off, 1 == on). 
But white led polarity is inverted (1 == off, 0 == on).

> +	partition at 500000 {
> +		label = "pogoplug";
> +		reg = <0x0500000 0x2000000>;
> +	};

I don't think pogoplug is the proper label for this partition. It seems 
duplicated from "kirkwood-goflexnet.dts" I guess you could label it 
"data" for instance.

Tested-by: Yoann Sculo <yoann@printk.fr>

Yoann
