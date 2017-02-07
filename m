From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 7 Feb 2017 20:39:46 -0200
Subject: [PATCH] ARM: dts: imx6q-cm-fx6: add analog audio support
In-Reply-To: <b6776a0aa8484faf816a238705ed6d22@rwthex-s1-b.rwth-ad.de>
References: <b6776a0aa8484faf816a238705ed6d22@rwthex-s1-b.rwth-ad.de>
Message-ID: <CAOMZO5BqkEQ5=rJpufuiqethOtRFqnm7pyoBR7hkS=e6iUsQAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 7, 2017 at 6:31 PM,  <christopher.spinrath@rwth-aachen.de> wrote:

> +&audmux {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_audmux>;
> +       status = "okay";
> +
> +       ssi2 {
> +               fsl,audmux-port = <1>;
> +               fsl,port-config = <
> +                       (IMX_AUDMUX_V2_PTCR_RCLKDIR |
> +                       IMX_AUDMUX_V2_PTCR_RCSEL(3 | 0x8) |
> +                       IMX_AUDMUX_V2_PTCR_TCLKDIR |
> +                       IMX_AUDMUX_V2_PTCR_TCSEL(3))
> +                       IMX_AUDMUX_V2_PDCR_RXDSEL(3)
> +               >;
> +       };
> +
> +       pins5 {

Just one minor nit: maybe pins4 since you are using AUD4 pins. Or
maybe 'audmux4' as pins4 is too vague ?

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
