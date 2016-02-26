From: tony@atomide.com (Tony Lindgren)
Date: Fri, 26 Feb 2016 11:13:43 -0800
Subject: [PATCH] ARM: dts: dra7: Support QSPI MODE-0 operation at 64MHz
In-Reply-To: <1456375652-14071-1-git-send-email-vigneshr@ti.com>
References: <1456375652-14071-1-git-send-email-vigneshr@ti.com>
Message-ID: <20160226191342.GF13417@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Vignesh R <vigneshr@ti.com> [160224 20:49]:
> According to Data Manual(SPRS915P) of AM57x, TI QSPI controller on
> DRA74(rev 1.1+) can support up to 64MHz in MODE-0, whereas MODE-3 is
> limited to 48MHz. Hence, switch to MODE-0 for better throughput.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  arch/arm/boot/dts/dra7-evm.dts | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
> index cfc24e52244e..15f10bdc8c31 100644
> --- a/arch/arm/boot/dts/dra7-evm.dts
> +++ b/arch/arm/boot/dts/dra7-evm.dts
> @@ -653,15 +653,13 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&qspi1_pins>;
>  
> -	spi-max-frequency = <48000000>;
> +	spi-max-frequency = <64000000>;
>  	m25p80 at 0 {
>  		compatible = "s25fl256s1";
> -		spi-max-frequency = <48000000>;
> +		spi-max-frequency = <64000000>;
>  		reg = <0>;
>  		spi-tx-bus-width = <1>;
>  		spi-rx-bus-width = <4>;
> -		spi-cpol;
> -		spi-cpha;
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  

Do we have any earlier pre DRA74(rev 1.1)versions in use too?

What about the spi-cpol and spi-cpha changes? Those should be
at least documented?

Regards,

Tony
