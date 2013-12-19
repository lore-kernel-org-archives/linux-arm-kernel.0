From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 19 Dec 2013 14:57:06 +0800
Subject: [PATCH 3/3] thermal: imx: add clk info for thermal sensor
In-Reply-To: <1387477045-19037-3-git-send-email-b20788@freescale.com>
References: <1387477045-19037-1-git-send-email-b20788@freescale.com>
 <1387477045-19037-3-git-send-email-b20788@freescale.com>
Message-ID: <20131219065704.GA6691@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 01:17:25PM -0500, Anson Huang wrote:
> thermal sensor needs dedicated clock to work in correct way,
> so we need to add necessary clock info in dts.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
>  .../devicetree/bindings/thermal/imx-thermal.txt    |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.txt b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> index 541c25e..e518c6e 100644
> --- a/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> @@ -7,6 +7,7 @@ Required properties:
>  - fsl,tempmon-data : phandle pointer to fuse controller that contains TEMPMON
>    calibration data, e.g. OCOTP on imx6q.  The details about calibration data
>    can be found in SoC Reference Manual.
> +- clocks : thermal sensor's clock source.

For such binding update, it can just be merged into driver patch.  Also,
it has to be an optional property.  See my reply to the driver patch.

Shawn

>  
>  Example:
>  
> @@ -14,4 +15,5 @@ tempmon {
>  	compatible = "fsl,imx6q-tempmon";
>  	fsl,tempmon = <&anatop>;
>  	fsl,tempmon-data = <&ocotp>;
> +	clocks = <&clks 172>;
>  };
> -- 
> 1.7.9.5
> 
> 
