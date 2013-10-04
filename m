From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 04 Oct 2013 12:22:32 +0200
Subject: [PATCH] ARM: Dove: fix bad properties of the si5351 clkout2 used
 by Cubox audio
In-Reply-To: <20131004122105.60f605cd@armhf>
References: <20131004122105.60f605cd@armhf>
Message-ID: <524E96E8.5030103@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/2013 12:21 PM, Jean-Francois Moine wrote:
> As defined in the DT, clkout2 is not allowed to change the pll inside
> si5351.
>
> This patch inverts the properties of the clkout{1,2} so that clkout2
> may be defined as the external clock of the audio device in the Cubox.
>
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>   arch/arm/boot/dts/dove-cubox.dts | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/dove-cubox.dts b/arch/arm/boot/dts/dove-cubox.dts
> index 022646e..5d1ece1 100644
> --- a/arch/arm/boot/dts/dove-cubox.dts
> +++ b/arch/arm/boot/dts/dove-cubox.dts
> @@ -101,16 +101,16 @@
>
>   		clkout1 {
>   			reg = <1>;
> -			silabs,drive-strength = <8>;
>   			silabs,multisynth-source = <1>;
>   			silabs,clock-source = <0>;
> -			silabs,pll-master;
>   		};

Jean-Francois,

thanks for the patch! If we have no use for clkout1 at all on CuBox,
we can also remove the above completely.

For this or an updated patch which removes clkout1 completely:

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

>   		clkout2 {
>   			reg = <2>;
> +			silabs,drive-strength = <8>;
>   			silabs,multisynth-source = <1>;
>   			silabs,clock-source = <0>;
> +			silabs,pll-master;
>   		};
>   	};
>   };
>
