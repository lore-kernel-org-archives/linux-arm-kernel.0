From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 20 Feb 2017 17:11:20 -0300
Subject: [PATCH v2 2/4] arm: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual
 OpenFrame Cap 10.1 initial support
In-Reply-To: <1487621121-6051-2-git-send-email-jagan@openedev.com>
References: <1487621121-6051-1-git-send-email-jagan@openedev.com>
 <1487621121-6051-2-git-send-email-jagan@openedev.com>
Message-ID: <CAOMZO5CKQaDvnr2-EzO_3ZOwQWb4RM1ytKiLfvXCj9Azwco8zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2017 at 5:05 PM, Jagan Teki <jagan@openedev.com> wrote:

> +&ldb {
> +       status = "okay";
> +
> +       lvds-channel at 0 {
> +               fsl,data-mapping = "spwg";
> +               fsl,data-width = <24>;
> +               status = "okay";
> +
> +               display-timings {
> +                        native-mode = <&timing1>;
> +                        timing1: hsd100pxn1 {
> +                                clock-frequency = <60000000>;
> +                                hactive = <1280>;
> +                                vactive = <800>;
> +                                hback-porch = <40>;
> +                                hfront-porch = <40>;
> +                                vback-porch = <10>;
> +                                vfront-porch = <3>;
> +                                hsync-len = <80>;
> +                                vsync-len = <10>;

hsd100pxn1 is supported by the drm simple panel driver.

This allows you to remove the display-timings from the dts and use
compatible = "hannstar,hsd100pxn1" instead.
