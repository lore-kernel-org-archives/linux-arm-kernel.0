From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 22 Jan 2013 20:40:24 +0100
Subject: [PATCH] Dove: activate GPIO interrupts in DT
In-Reply-To: <20130122112845.4f7c0f38@armhf>
References: <20130122112845.4f7c0f38@armhf>
Message-ID: <50FEEB28.8020000@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/22/2013 11:28 AM, Jean-Francois Moine wrote:
> In a DT, the interrupts of an interrupt-controller are not usable when
> #interrupt-cells is missing.
>
> This patch activates the interrupts of the GPIOs 0 and 1 for the Marvell
> Dove SoC.
>
> Signed-off-by: Jean-Fran?ois Moine<moinejf@free.fr>
>
> diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
> index 42eac1f..287fb12 100644
> --- a/arch/arm/boot/dts/dove.dtsi
> +++ b/arch/arm/boot/dts/dove.dtsi
> @@ -93,6 +93,7 @@
>   			reg =<0xd0400 0x20>;
>   			ngpios =<32>;
>   			interrupt-controller;
> +			#interrupt-cells =<1>;
>   			interrupts =<12>,<13>,<14>,<60>;
>   		};
>
> @@ -103,6 +104,7 @@
>   			reg =<0xd0420 0x20>;
>   			ngpios =<32>;
>   			interrupt-controller;
> +			#interrupt-cells =<1>;
>   			interrupts =<61>;
>   		};
>

Jean-Francois,

first thanks for sending the patch!

I checked Documentation/devicetree/bindings/gpio/gpio-mvebu.txt and there
#interrupt-cells is specified to be set to two. Further, I checked kirkwood.dtsi
and it is also missing the #interrupt-cells.

Can you please update your patch to have #interrupt-cells set to two? When you
resend v2 of the patch please Cc at least all I added.

I will send another patch fixing kirkwood.dtsi.

Sebastian
