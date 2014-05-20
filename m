From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 20 May 2014 20:09:06 +0200
Subject: [PATCH] ARM: dts: duovero-parlor: Add HDMI output
In-Reply-To: <1400595946-1294-1-git-send-email-florian.vaussard@epfl.ch>
References: <1400595946-1294-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <CAGhQ9VxtJwrKzW77mo=y9_gvCRW_8TJEp90OVN+YPg2RpC=b_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 May 2014 16:25, Florian Vaussard <florian.vaussard@epfl.ch> wrote:
> Add the necessary DTS nodes to enable the micro-HDMI output on Parlor
> board.
>
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> ---
>  arch/arm/boot/dts/omap4-duovero-parlor.dts | 42 ++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/arch/arm/boot/dts/omap4-duovero-parlor.dts b/arch/arm/boot/dts/omap4-duovero-parlor.dts
> index 96f51d8..3b234b8 100644
> --- a/arch/arm/boot/dts/omap4-duovero-parlor.dts
> +++ b/arch/arm/boot/dts/omap4-duovero-parlor.dts
> @@ -15,6 +15,10 @@
>         model = "OMAP4430 Gumstix Duovero on Parlor";
>         compatible = "gumstix,omap4-duovero-parlor", "gumstix,omap4-duovero", "ti,omap4430", "ti,omap4";
>
> +       aliases {
> +               display0 = &hdmi0;
> +       };
> +
>         leds {
>                 compatible = "gpio-leds";
>                 led0 {
> @@ -35,6 +39,19 @@
>                         gpio-key,wakeup;
>                 };
>         };
> +
> +       hdmi0: connector at 0 {
> +               compatible = "hdmi-connector";
> +               label = "hdmi";
> +
> +               type = "d";
> +
> +               port {
> +                       hdmi_connector_in: endpoint {
> +                               remote-endpoint = <&hdmi_out>;
> +                       };
> +               };
> +       };
>  };

No, HPD (hotplug) pin?

I think Parlor has one and the "hdmi-connector" binding now supports
it. See Tomi's 3.16/fbdev-omap branch.

regards
Joachim Eastwood
