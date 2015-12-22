From: naobsd@gmail.com (Naoki FUKAUMI)
Date: Tue, 22 Dec 2015 12:04:01 +0900
Subject: [PATCH 5/6] ARM: dts: rockchip: add reboot mode node
In-Reply-To: <1450698149-30260-1-git-send-email-andy.yan@rock-chips.com>
References: <1450697249-29994-1-git-send-email-andy.yan@rock-chips.com>
 <1450698149-30260-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <CAFnsNoQbeAsuESSPeDDs_fQvPv96pBX=jNh=ahpWrTKLrpEExw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

On Mon, Dec 21, 2015 at 8:42 PM, Andy Yan <andy.yan@rock-chips.com> wrote:
> Add reboot mode driver DT node for rk3xxx,rk3288 platform
>
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
>
>  arch/arm/boot/dts/rk3288.dtsi                | 25 +++++++++++++++++++++++
>  arch/arm/boot/dts/rk3xxx.dtsi                | 26 ++++++++++++++++++++++++
>  include/dt-bindings/soc/rockchip_boot-mode.h | 30 ++++++++++++++++++++++++++++
>  3 files changed, 81 insertions(+)
>  create mode 100644 include/dt-bindings/soc/rockchip_boot-mode.h
>
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 04ea209..937ba4c 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -170,6 +170,31 @@
>                 };
>         };
>
> +       reboot_mode {
> +               compatible = "rockchip,reboot-mode";
> +               rockchip,regmap = <&pmu>;
> +               offset = <0x94>;
> +               loader {
> +                       linux,mode = "loader";
> +                       linux,magic = <0x5242C301>;
> +               };
> +
> +               maskrom {
> +                       linux,mode = "maskrom";
> +                       linux,magic = <0x5242C302>;
> +               };
> +
> +               recovery {
> +                       linux,mode = "recovery";
> +                       linux,magic = <0x5242C303>;
> +               };
> +
> +               fastboot {
> +                       linux,mode = "fastboot";
> +                       linux,magic = <0x5242C309>;
> +               };
> +       };
> +
(snip)

I sometimes use 0xEF08A53C to load bootloader from SD card instead of
on-board flash memory such as eMMC.
 https://github.com/linux-rockchip/u-boot-rockchip/blob/u-boot-rk3288/common/cmd_rockusb.c#L893

I don't know any detail about this function.
(above code says "reboot to maskrom", but it should be wrong from my experience)

do you know something about this function? can you handle this too?

Regards,
