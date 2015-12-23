From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 Dec 2015 10:19:46 -0800
Subject: [PATCH 2/3] ARM: dts: am335x-evm: add shared transport device
 tree bindings
In-Reply-To: <8665E2433BC68541A24DFFCA87B70F5B23759A6B@DFRE01.ent.ti.com>
References: <1450870253-8694-1-git-send-email-eyalr@ti.com>
 <1450870253-8694-2-git-send-email-eyalr@ti.com>
 <8665E2433BC68541A24DFFCA87B70F5B23759A6B@DFRE01.ent.ti.com>
Message-ID: <20151223181945.GN2793@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Reizer, Eyal <eyalr@ti.com> [151223 03:40]:
> The shared Shared Transport (ST) software enables BT and GPS protocols
> or software components to interact with their respective cores over
> single physical port.
> Add the uart and enable pin device tree bindings
...
> --- a/arch/arm/boot/dts/am335x-evm.dts
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -160,6 +160,18 @@
>  			system-clock-frequency = <12000000>;
>  		};
>  	};
> +
> +	kim {
> +		compatible = "kim";
> +		nshutdown-gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
> +		serial-device = <&uart1>;
> +		flow_cntrl = <1>;
> +		baud_rate = <3000000>;
> +	};
> +
> +	btwilink {
> +		compatible = "btwilink";
> +	};
>  };

I think this "kim" binding got dropped.. We need some sane binding and
solution for it.

Regards,

Tony
