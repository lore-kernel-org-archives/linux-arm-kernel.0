From: cphealy@gmail.com (Chris Healy)
Date: Thu, 31 Aug 2017 10:39:59 -0700
Subject: [PATCH 2/2] ARM: dts: imx6: RDU2: disallow RMI4 device sleep
In-Reply-To: <20170831153951.7674-2-l.stach@pengutronix.de>
References: <20170831153951.7674-1-l.stach@pengutronix.de>
 <20170831153951.7674-2-l.stach@pengutronix.de>
Message-ID: <CAFXsbZqYgsyXLS7RatACXBNA2E2HMa3jvp3a1Wq_yOrQFFqtOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch has been successfully tested on the RDU2 platform and
addresses the issues that occur with touchscreen firmware power
management enabled.

Tested-by: Chris Healy <cphealy@gmail.com>

On Thu, Aug 31, 2017 at 8:39 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> This is causing issues with some specific controller configurations, as
> the platform isn't power limited it's better to keep it disabled.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> index c2cd7457bad3..ce95f282a70d 100644
> --- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> @@ -608,7 +608,7 @@
>
>                 rmi4-f01 at 1 {
>                         reg = <0x1>;
> -                       syna,nosleep-mode = <1>;
> +                       syna,nosleep-mode = <2>;
>                 };
>
>                 rmi4-f11 at 11 {
> --
> 2.11.0
>
