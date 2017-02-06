From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 6 Feb 2017 03:54:35 +0100
Subject: [PATCH V2 2/2] ARM: dts: rockchip: add dts for RK3288-Tinker board
In-Reply-To: <1486347287-31051-3-git-send-email-eddie.cai@rock-chips.com>
References: <1486347287-31051-1-git-send-email-eddie.cai@rock-chips.com>
 <1486347287-31051-3-git-send-email-eddie.cai@rock-chips.com>
Message-ID: <20170206025435.GA32506@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eddie

> +		button at 0 {
> +			gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
> +			linux,code = <116>;

It is a good idea to use include/dt-bindings/input/input.h

and then you can replace <116> with < KEY_POWER > which is more
readable.

> +			label = "GPIO Key Power";
> +			linux,input-type = <1>;

< EV_KEY >

> +			gpio-key,wakeup = <1>;

This has been replace with wakeup-source.

> +			debounce-interval = <100>;
> +		};
> +	};

  Andrew
