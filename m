From: gmbnomis@gmail.com (Simon Baatz)
Date: Fri, 16 Nov 2012 20:32:50 +0100
Subject: [PATCH v2 3/3] ARM: Kirkwood: Convert IB62x0 to use gpio-poweroff.
In-Reply-To: <1352821485-10032-4-git-send-email-andrew@lunn.ch>
References: <1352821485-10032-1-git-send-email-andrew@lunn.ch>
 <1352821485-10032-4-git-send-email-andrew@lunn.ch>
Message-ID: <20121116193250.GB25838@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Tue, Nov 13, 2012 at 04:44:45PM +0100, Andrew Lunn wrote:
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/boot/dts/kirkwood-ib62x0.dts |    6 ++++++
>  arch/arm/mach-kirkwood/board-ib62x0.c |   13 -------------
>  2 files changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-ib62x0.dts b/arch/arm/boot/dts/kirkwood-ib62x0.dts
> index 66794ed..9b0e2e3 100644
> --- a/arch/arm/boot/dts/kirkwood-ib62x0.dts
> +++ b/arch/arm/boot/dts/kirkwood-ib62x0.dts
> @@ -79,4 +79,10 @@
>  			gpios = <&gpio0 27 0>;
>  		};
>  	};
> +	gpio_poweroff {
> +		compatible = "gpio-poweroff";
> +		gpios = <&gpio0 24 1>;

This needs to be:
		gpios = <&gpio0 24 0>;

If the GPIO is configured as an input, the box shuts down when
initializing the driver.

With this change:

Tested-by: Simon Baatz <gmbnomis@gmail.com>

Btw., I also tested it on top of your pinctrl changes, which works
like a charm as well.

- Simon
