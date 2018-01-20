From: maggu2810@gmail.com (Markus Rathgeb)
Date: Sat, 20 Jan 2018 10:14:41 +0100
Subject: [PATCH] ARM: dts: imx6qdl-udoo: Disable usbh1 to avoid kernel hang
In-Reply-To: <1516278858-15464-1-git-send-email-fabio.estevam@nxp.com>
References: <1516278858-15464-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <CAOcK=CMFahBh9rmm5PGHe=UVrdxi_pwWH=cOs9Q_kCgzTTKOew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-01-18 13:34 GMT+01:00 Fabio Estevam <fabio.estevam@nxp.com>:
> Currently the kernel hangs when USB Host1 is enabled due to the lack of
> support for controlling the USB hub clock and GPIO reset line.
>
> Peter Chen has made several attempts to fix this problem, but his series
> has not been applied yet, so better disable USB host1 for now to avoid
> the kernel hang.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/arm/boot/dts/imx6qdl-udoo.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/imx6qdl-udoo.dtsi b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
> index 4161b7d..1f0b9f6 100644
> --- a/arch/arm/boot/dts/imx6qdl-udoo.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
> @@ -274,7 +274,8 @@
>         pinctrl-0 = <&pinctrl_usbh>;
>         vbus-supply = <&reg_usb_h1_vbus>;
>         clocks = <&clks IMX6QDL_CLK_CKO>;
> -       status = "okay";
> +       /* currently USB support causes a kernel hang. Disable it for now */
> +       status = "disabled";
>  };
>
>  &usdhc3 {
> --
> 2.7.4
>

I tested the patch that sets usbh1's status to disable using the
kernel 4.13 that previously hangs.
I confirm the disabled usb host allows to boot my imx6q-udoo board.

Tested-by: Markus Rathgeb <maggu2810@gmail.com>
