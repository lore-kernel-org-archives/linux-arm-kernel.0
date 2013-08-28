From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 28 Aug 2013 12:14:24 +0200
Subject: [PATCH 2/2] ARM: Dove: Add the audio device to the Cubox DT
In-Reply-To: <20130828113521.35c53365@armhf>
References: <20130828113521.35c53365@armhf>
Message-ID: <521DCD80.9010105@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/28/2013 11:35 AM, Jean-Francois Moine wrote:
> This patch activates the audio device of the Cubox and sets the i2s
> and S/PDIF pins.
>
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>   arch/arm/boot/dts/dove-cubox.dts                  | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm/boot/dts/dove-cubox.dts b/arch/arm/boot/dts/dove-cubox.dts
> index 4af59b6..003d95b 100644
> --- a/arch/arm/boot/dts/dove-cubox.dts
> +++ b/arch/arm/boot/dts/dove-cubox.dts
> @@ -132,3 +132,16 @@
>   		reg = <0>;
>   	};
>   };
> +
> +&pinctrl {
> +	pmx_audio1_i2s1_spdifo: pmx-audio1-i2s1-spdifo {
> +		marvell,pins = "mpp_audio1";
> +		marvell,function = "i2s1/spdifo";
> +	};
> +};
> +
> +&i2s1 {
> +	status = "okay";
> +	pinctrl-0 = <&pmx_audio1_i2s1_spdifo>;
> +	pinctrl-names = "default";
> +};

Please also add the external clock connected from si5351.

Sebastian
