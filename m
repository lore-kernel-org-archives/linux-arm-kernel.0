From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Tue, 6 Aug 2013 11:39:57 +0530
Subject: [PATCH RESEND] ARM: dts: Add USBPHY nodes to Exynos4x12
In-Reply-To: <1375726723-20862-1-git-send-email-tobetter@gmail.com>
References: <1375726723-20862-1-git-send-email-tobetter@gmail.com>
Message-ID: <CAK9yfHwxVtJFZMQNoh-RepaF53L_TruPBSUt3YH_XY+8iXjffA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dongjin,

On 5 August 2013 23:48, Dongjin Kim <tobetter@gmail.com> wrote:
> This patch adds device nodes for USBPHY to Exynos4x12.
>
> CC: Sachin Kamat <sachin.kamat@linaro.org>
> Signed-off-by: Dongjin Kim <tobetter@gmail.com>
> ---
>  arch/arm/boot/dts/exynos4x12.dtsi |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
> index 01da194..9c3335b 100644
> --- a/arch/arm/boot/dts/exynos4x12.dtsi
> +++ b/arch/arm/boot/dts/exynos4x12.dtsi
> @@ -73,4 +73,22 @@
>                 clock-names = "sclk_fimg2d", "fimg2d";
>                 status = "disabled";
>         };
> +
> +       usbphy at 125B00000 {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "samsung,exynos4x12-usb2phy";
> +               reg = <0x125B0000 0x100>;
> +               ranges;
> +
> +               clocks = <&clock 2>, <&clock 305>;
> +               clock-names = "xusbxti", "otg";
> +               status = "disabled";

I don't think this node has any other board specific dependencies. In
that case you don't need to disable this.

> +
> +               usbphy-sys {
> +                       /* USB device and host PHY_CONTROL registers */
> +                       reg = <0x10020704 0xc>,
> +                             <0x1001021c 0x4>;
> +               };
> +       };
>  };
> --
> 1.7.9.5
>



-- 
With warm regards,
Sachin
