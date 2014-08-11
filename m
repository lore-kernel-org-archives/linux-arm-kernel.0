From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Mon, 11 Aug 2014 16:03:52 -0500
Subject: [PATCHv10 4/5] ARM: dts: socfpga: unuse the slot-node and
 deprecate the supports-highspeed for dw-mmc
In-Reply-To: <1407397082-32495-5-git-send-email-jh80.chung@samsung.com>
References: <1407397082-32495-1-git-send-email-jh80.chung@samsung.com>
 <1407397082-32495-5-git-send-email-jh80.chung@samsung.com>
Message-ID: <CADhT+wcKrL8f-OyLnKKzsBgyU3PSYFLfsZgvCcdAgVV5BAT76Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 7, 2014 at 2:38 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> dw-mmc controller can support multiple slots.
> But, there are no use-cases anywhere. So we don't need to support the
> slot-node for dw-mmc controller.
> And "supports-highspeed" property in dw-mmc is deprecated.
> "supports-highspeed" property can be replaced with "cap-sd/mmc-highspeed".
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Reviewed-by: Tushar Behera <trblinux@gmail.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
> Acked-by: Dinh Nguyen <dinguyen@altera.com>
> ---

I've queued this patch in my tree for v3.18.

Thanks,
Dinh

>  arch/arm/boot/dts/socfpga_arria5.dtsi   |    9 +++------
>  arch/arm/boot/dts/socfpga_cyclone5.dtsi |    9 +++------
>  arch/arm/boot/dts/socfpga_vt.dts        |    9 +++------
>  3 files changed, 9 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm/boot/dts/socfpga_arria5.dtsi b/arch/arm/boot/dts/socfpga_arria5.dtsi
> index 12d1c2c..468fc4c 100644
> --- a/arch/arm/boot/dts/socfpga_arria5.dtsi
> +++ b/arch/arm/boot/dts/socfpga_arria5.dtsi
> @@ -29,13 +29,10 @@
>
>                 dwmmc0 at ff704000 {
>                         num-slots = <1>;
> -                       supports-highspeed;
>                         broken-cd;
> -
> -                       slot at 0 {
> -                               reg = <0>;
> -                               bus-width = <4>;
> -                       };
> +                       bus-width = <4>;
> +                       cap-mmc-highspeed;
> +                       cap-sd-highspeed;
>                 };
>
>                 sysmgr at ffd08000 {
> diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dtsi b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
> index bf51182..1ee03c4 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5.dtsi
> +++ b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
> @@ -30,13 +30,10 @@
>
>                 dwmmc0 at ff704000 {
>                         num-slots = <1>;
> -                       supports-highspeed;
>                         broken-cd;
> -
> -                       slot at 0 {
> -                               reg = <0>;
> -                               bus-width = <4>;
> -                       };
> +                       bus-width = <4>;
> +                       cap-mmc-highspeed;
> +                       cap-sd-highspeed;
>                 };
>
>                 ethernet at ff702000 {
> diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
> index 09792b4..f9345e0 100644
> --- a/arch/arm/boot/dts/socfpga_vt.dts
> +++ b/arch/arm/boot/dts/socfpga_vt.dts
> @@ -43,13 +43,10 @@
>
>                 dwmmc0 at ff704000 {
>                         num-slots = <1>;
> -                       supports-highspeed;
>                         broken-cd;
> -
> -                       slot at 0 {
> -                               reg = <0>;
> -                               bus-width = <4>;
> -                       };
> +                       bus-width = <4>;
> +                       cap-mmc-highspeed;
> +                       cap-sd-highspeed;
>                 };
>
>                 ethernet at ff700000 {
> --
> 1.7.9.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
