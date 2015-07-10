From: robherring2@gmail.com (Rob Herring)
Date: Fri, 10 Jul 2015 14:58:30 -0500
Subject: [PATCH v4 5/7] dt-binding: document the binding for mxc rtc
In-Reply-To: <1435965320-1478-6-git-send-email-tremyfr@gmail.com>
References: <1435965320-1478-1-git-send-email-tremyfr@gmail.com>
 <1435965320-1478-6-git-send-email-tremyfr@gmail.com>
Message-ID: <CAL_Jsq+4AbvtYiYXydKpq5y_tv_6OVoa-Q35XeePsND2zhPfkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 3, 2015 at 6:15 PM, Philippe Reynes <tremyfr@gmail.com> wrote:
> This adds documentation of device tree bindings for the
> mxc rtc.
>
> Cc: Rob Herring <robh+dt@kernel.org>

Ack.

One typo below.

> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
> ---
>  Documentation/devicetree/bindings/rtc/rtc-mxc.txt |   27 +++++++++++++++++++++
>  1 files changed, 27 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mxc.txt
>
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-mxc.txt b/Documentation/devicetree/bindings/rtc/rtc-mxc.txt
> new file mode 100644
> index 0000000..5505493
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/rtc-mxc.txt
> @@ -0,0 +1,27 @@
> +* Real Time Clock of the i.MX SoCs
> +
> +RTC controller for the i.MX SoCs
> +
> +Required properties:
> +- compatible: Should be "fsl,imx1-rtc" or "fsl,imx21-rtc".
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +- interrupts: IRQ line for the RTC.
> +- clocks: should contain two entries:
> +  * one for the input reference
> +  * one for the the SoC RTC
> +- clock-names: should contain:
> +  * "rtc" for the input reference clock
> +  * "ipg" for the SoC RTC clock
> +
> +Example:
> +
> +rtc at 10007000 {
> +       compatible = "fsl,imx21-rtc";
> +       reg = <0x10007000 0x1000>;
> +       interrupts = <22>;
> +       clocks = <&clks IMX27_CLK_CKIL>,
> +                <&clks IMX27_CLK_RTC_IPG_GATE>;
> +       clock-names = "rtc, "ipg";

Missing ".

> +       status = "disabled";
> +};
> --
> 1.7.4.4
>
