From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 2 Apr 2016 18:26:56 +0200
Subject: [PATCH] ARM: dts: kirkwood: Add DTS for Linksys EA4200v2/EA4500
In-Reply-To: <1459601753-31193-1-git-send-email-bert@biot.com>
References: <1459601753-31193-1-git-send-email-bert@biot.com>
Message-ID: <20160402162656.GG32554@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +		button at 15 {
> +			label = "WPS Button";
> +			linux,code = <KEY_WPS_BUTTON>;
> +			gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		button at 16 {
> +			label = "Reset Button";
> +			linux,code = <KEY_RESTART>;
> +			gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
> +		};
> +	};

I'm looking at the warnings the new DT compiler produces....

Buttons should not have a @15, etc, since they don't have a register
property.

If you can, it would be good it you can compile your .dts file using
the dtc compile in linux-next and pass W=1.

	Andrew
