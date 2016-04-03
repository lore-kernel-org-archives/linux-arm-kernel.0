From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 3 Apr 2016 19:19:07 +0200
Subject: [PATCH] ARM64: dts: amlogic: Add hiu and periphs buses
In-Reply-To: <1459703681-8689-1-git-send-email-carlo@caione.org>
References: <1459703681-8689-1-git-send-email-carlo@caione.org>
Message-ID: <5701508B.1050403@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 03.04.2016 um 19:14 schrieb Carlo Caione:
> From: Carlo Caione <carlo@endlessm.com>
> 
> Add two new buses in the DTS: hiu and periphs buses.
> In the Amlogic S905/GXBB SoC several devices (clock / eth / pin
> controllers, etc...) are mapped under these two buses. Add them in the
> DT before starting to add new devices.
> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> index 832815d..3126f0c 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> @@ -167,6 +167,22 @@
>  			};
>  		};
>  
> +		periphs: periphs at c8834000 {
> +			compatible = "simple-bus";
> +			reg = <0x0 0xc8834000 0x0 0x2000>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges = <0x0 0x0 0x0 0xc8834000 0x0 0x2000>;
> +		};
> +
> +		hiubus: hiubus at c883c000 {
> +			compatible = "simple-bus";
> +			reg = <0x0 0xc883c000 0x0 0x2000>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges = <0x0 0x0 0x0 0xc883c000 0x0 0x2000>;
> +		};
> +
>  		apb: apb at d0000000 {
>  			compatible = "simple-bus";
>  			reg = <0x0 0xd0000000 0x0 0x200000>;

Looks sane, but where did you get that info from? The others I had found
in an iomap node or so but did not spot these.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
