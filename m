From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 13 Mar 2017 20:22:53 +0800
Subject: [PATCH v4 5/7] arm: dts: imx6q-icore: Add touchscreen node
In-Reply-To: <1488957477-5621-5-git-send-email-jagan@openedev.com>
References: <1488957477-5621-1-git-send-email-jagan@openedev.com>
 <1488957477-5621-5-git-send-email-jagan@openedev.com>
Message-ID: <20170313122252.GE3618@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 08, 2017 at 12:47:55PM +0530, Jagan Teki wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
> 
> max11801 touchscreen on Engicam iCoreM6 Quad module is
> connected via i2c1, so add tc: max11801 at 48 on i2c1.
> 
> Cc: Domenico Acri <domenico.acri@engicam.com>
> Cc: Matteo Lisi <matteo.lisi@engicam.com>
> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v4:
> - Newly added patch.
> 
>  arch/arm/boot/dts/imx6q-icore.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6q-icore.dts b/arch/arm/boot/dts/imx6q-icore.dts
> index 73f34d1..8c1a572 100644
> --- a/arch/arm/boot/dts/imx6q-icore.dts
> +++ b/arch/arm/boot/dts/imx6q-icore.dts
> @@ -58,6 +58,15 @@
>  	status = "okay";
>  };
>  
> +&i2c1 {
> +	ts: max11801 at 48 {
> +		compatible = "max11801";

Undocumented compatible?

Shawn

> +		reg = <0x48>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
> +	};
> +};
> +
>  &ldb {
>  	status = "okay";
>  
> -- 
> 1.9.1
> 
