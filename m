From: robherring2@gmail.com (Rob Herring)
Date: Thu, 5 Jun 2014 03:43:14 -0500
Subject: [PATCH] arm64: dts: Add more serial port nodes in APM X-Gene
 device tree
In-Reply-To: <1395836346-9350-1-git-send-email-vkale@apm.com>
References: <1395836346-9350-1-git-send-email-vkale@apm.com>
Message-ID: <CAL_JsqKm-WktP+ad7aEMAPe=zhB7TPOftktUhccXyn=70wnLfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 7:19 AM, Vinayak Kale <vkale@apm.com> wrote:
> APM X-Gene Storm SoC supports 4 serial ports. This patch adds device nodes
> for serial ports 1 to 3 (a device node for serial port 0 is already present
> in the dts file).
> This patch also sets the compatible property of serial nodes to "ns16550a".
>
> Signed-off-by: Vinayak Kale <vkale@apm.com>
> ---
>  arch/arm64/boot/dts/apm-mustang.dts |  4 ++++
>  arch/arm64/boot/dts/apm-storm.dtsi  | 36 +++++++++++++++++++++++++++++++++++-
>  2 files changed, 39 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/apm-mustang.dts b/arch/arm64/boot/dts/apm-mustang.dts
> index 1247ca1..6541962 100644
> --- a/arch/arm64/boot/dts/apm-mustang.dts
> +++ b/arch/arm64/boot/dts/apm-mustang.dts
> @@ -24,3 +24,7 @@
>                 reg = < 0x1 0x00000000 0x0 0x80000000 >; /* Updated by bootloader */
>         };
>  };
> +
> +&serial0 {
> +       status = "ok";
> +};
> diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
> index d37d736..2277b5c 100644
> --- a/arch/arm64/boot/dts/apm-storm.dtsi
> +++ b/arch/arm64/boot/dts/apm-storm.dtsi
> @@ -179,13 +179,47 @@
>                 };
>
>                 serial0: serial at 1c020000 {
> +                       status = "disabled";
>                         device_type = "serial";
> -                       compatible = "ns16550";
> +                       compatible = "ns16550a";

Generally, changing a compatible string like this is a no-no. You
could be breaking compatibility with different OS versions. However,
this is one generic string to another and they have been around
forever, so I think it is okay. You probably should have a specific
string in case you ever have some quirk in your particular h/w.

Acked-by: Rob Herring <robh@kernel.org>

Rob

>                         reg = <0 0x1c020000 0x0 0x1000>;
>                         reg-shift = <2>;
>                         clock-frequency = <10000000>; /* Updated by bootloader */
>                         interrupt-parent = <&gic>;
>                         interrupts = <0x0 0x4c 0x4>;
>                 };
> +
> +               serial1: serial at 1c021000 {
> +                       status = "disabled";
> +                       device_type = "serial";
> +                       compatible = "ns16550a";
> +                       reg = <0 0x1c021000 0x0 0x1000>;
> +                       reg-shift = <2>;
> +                       clock-frequency = <10000000>; /* Updated by bootloader */
> +                       interrupt-parent = <&gic>;
> +                       interrupts = <0x0 0x4d 0x4>;
> +               };
> +
> +               serial2: serial at 1c022000 {
> +                       status = "disabled";
> +                       device_type = "serial";
> +                       compatible = "ns16550a";
> +                       reg = <0 0x1c022000 0x0 0x1000>;
> +                       reg-shift = <2>;
> +                       clock-frequency = <10000000>; /* Updated by bootloader */
> +                       interrupt-parent = <&gic>;
> +                       interrupts = <0x0 0x4e 0x4>;
> +               };
> +
> +               serial3: serial at 1c023000 {
> +                       status = "disabled";
> +                       device_type = "serial";
> +                       compatible = "ns16550a";
> +                       reg = <0 0x1c023000 0x0 0x1000>;
> +                       reg-shift = <2>;
> +                       clock-frequency = <10000000>; /* Updated by bootloader */
> +                       interrupt-parent = <&gic>;
> +                       interrupts = <0x0 0x4f 0x4>;
> +               };
>         };
>  };
> --
> 1.8.2.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
