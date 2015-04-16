From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 16 Apr 2015 16:43:05 -0300
Subject: [PATCH v2 8/9] arm: dts: add imx7d-sdb support
In-Reply-To: <1429211860-14438-9-git-send-email-Frank.Li@freescale.com>
References: <1429211860-14438-1-git-send-email-Frank.Li@freescale.com>
 <1429211860-14438-9-git-send-email-Frank.Li@freescale.com>
Message-ID: <CAOMZO5A_jVdipqe=W+Q-wRRz7f3np8Q1=itVc5kk5VoGpkKWCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frank,

On Thu, Apr 16, 2015 at 4:17 PM,  <Frank.Li@freescale.com> wrote:

> +       pxp_v4l2_out {
> +               compatible = "fsl,imx7d-pxp-v4l2", "fsl,imx6sx-pxp-v4l2", "fsl,imx6sl-pxp-v4l2";
> +               status = "okay";
> +       };

Not supported in mainline. Please remove it.

> +       bcmdhd_wlan_0: bcmdhd_wlan at 0 {
> +               compatible = "android,bcmdhd_wlan";
> +               wlreg_on-supply = <&wlreg_on>;
> +       };

Same here.

> +
> +       sound {
> +               compatible = "fsl,imx7d-evk-wm8960",
> +                          "fsl,imx-audio-wm8960";
> +               model = "wm8960-audio";
> +               cpu-dai = <&sai1>;
> +               audio-codec = <&codec>;
> +               codec-master;
> +       };
> +
> +       sound-hdmi {
> +               compatible = "fsl,imx7d-sdb-sii902x",
> +                          "fsl,imx-audio-sii902x";

Not supported in mainline.

> +       sii902x: sii902x at 39 {
> +               compatible = "SiI,sii902x";

Same here.

> +&iomuxc {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_hog_1>;
> +
> +       imx7d-sdb {
> +               pinctrl_hog_1: hoggrp-1 {
> +                       fsl,pins = <
> +                               MX7D_PAD_UART3_CTS_B__GPIO4_IO7 0x14
> +                               MX7D_PAD_ECSPI2_SS0__GPIO4_IO23  0x80000000  /* bt reg on */

Please avoid using 0x80000000 for pad configuration. Use the real
value instead, so that we don't rely on the bootloader settings.
