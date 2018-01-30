From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 Jan 2018 11:27:59 +0100
Subject: [PATCH 2/2] arm64: dts: marvell: mcbin: enable uart headers
In-Reply-To: <97a7416bb0eb19c9d32e41984e292a869ff14230.1517299286.git.baruch@tkos.co.il>
References: <1ebd25aace6c9ab93abe7fb6e42ef9e275eee321.1517299286.git.baruch@tkos.co.il>
 <97a7416bb0eb19c9d32e41984e292a869ff14230.1517299286.git.baruch@tkos.co.il>
Message-ID: <20180130112759.3dfd1953@windsurf.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 30 Jan 2018 10:01:26 +0200, Baruch Siach wrote:
> Add description of the J25 and J27 UART headers of the Macchiatobin. They use
> uart peripherals that the CP0 (J25) and CP1 (J27) provides.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Thanks. One minor nit below.

> ---
>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> index 626e9d0462c3..3ce15b740bb0 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> @@ -163,6 +163,12 @@
>  	};
>  };
>  
> +&cp0_uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&cp0_uart1_pins>;
> +	status = "okay";
> +};

It'd be nice to indicate in the DT that this is accessible through J25.

> +&cp1_uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&cp1_uart0_pins>;
> +	status = "okay";
>  };

And this through J27.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
