From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 18 Mar 2018 10:03:43 -0300
Subject: [PATCH 2/2] ARM: dts: imx6sx-sabreauto: add external 24MHz clock
 source
In-Reply-To: <1521342853-2941-2-git-send-email-Anson.Huang@nxp.com>
References: <1521342853-2941-1-git-send-email-Anson.Huang@nxp.com>
 <1521342853-2941-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5CG6XuJ7N8W--zEwEVd9JHj887_7aNp+K8D-Xt1OnKh7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 18, 2018 at 12:14 AM, Anson Huang <Anson.Huang@nxp.com> wrote:

> diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> index 72da5ac..83f7cac 100644
> --- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
> +++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> @@ -18,6 +18,14 @@
>                 reg = <0x80000000 0x80000000>;
>         };
>
> +       clocks {
> +               codec_osc: anaclk2 {
> +                       #clock-cells = <0>;
> +                       compatible = "fixed-clock";
> +                       clock-frequency = <24576000>;
> +               };
> +       };

The clocks container should be removed and the clock node could be put
directly into the root node.

Also, I do not see 'codec_osc' being used in this dts.
