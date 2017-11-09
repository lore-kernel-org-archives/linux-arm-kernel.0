From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 09 Nov 2017 05:33:40 +0200
Subject: [PATCH 1/4] omapdrm: fix compatible string for td028ttec1
In-Reply-To: <8678120467a1d0e67d4d882b3f01d58867586653.1510175371.git.hns@goldelico.com>
References: <cover.1510175371.git.hns@goldelico.com>
 <8678120467a1d0e67d4d882b3f01d58867586653.1510175371.git.hns@goldelico.com>
Message-ID: <2790033.EQlQQc1BPI@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nikolaus,

Thank you for the patch.

On Wednesday, 8 November 2017 23:09:29 EET H. Nikolaus Schaller wrote:
> The vendor name was "toppoly" but other panels and the vendor list
> have defined it as "tpo". So let's fix it in driver and bindings.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  .../display/panel/{toppoly,td028ttec1.txt => tpo,td028ttec1.txt} | 4 ++--
> drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c           | 4 ++--
> drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c  | 4 ++--
> 3 files changed, 6 insertions(+), 6 deletions(-)
>  rename
> Documentation/devicetree/bindings/display/panel/{toppoly,td028ttec1.txt =>
> tpo,td028ttec1.txt} (84%)
> 
> diff --git
> a/Documentation/devicetree/bindings/display/panel/toppoly,td028ttec1.txt
> b/Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt
> similarity index 84%
> rename from
> Documentation/devicetree/bindings/display/panel/toppoly,td028ttec1.txt
> rename to
> Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt index
> 7175dc3740ac..ed34253d9fb1 100644
> --- a/Documentation/devicetree/bindings/display/panel/toppoly,td028ttec1.txt
> +++ b/Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt @@
> -2,7 +2,7 @@ Toppoly TD028TTEC1 Panel
>  ========================
> 
>  Required properties:
> -- compatible: "toppoly,td028ttec1"
> +- compatible: "tpo,td028ttec1"
> 
>  Optional properties:
>  - label: a symbolic name for the panel
> @@ -14,7 +14,7 @@ Example
>  -------
> 
>  lcd-panel: td028ttec1 at 0 {
> -	compatible = "toppoly,td028ttec1";
> +	compatible = "tpo,td028ttec1";
>  	reg = <0>;
>  	spi-max-frequency = <100000>;
>  	spi-cpol;
> diff --git a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
> b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c index
> 0a38a0e8c925..2dab491478c2 100644
> --- a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
> +++ b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
> @@ -452,7 +452,7 @@ static int td028ttec1_panel_remove(struct spi_device
> *spi) }
> 
>  static const struct of_device_id td028ttec1_of_match[] = {
> -	{ .compatible = "omapdss,toppoly,td028ttec1", },
> +	{ .compatible = "omapdss,tpo,td028ttec1", },

Doesn't this break backward compatibility with existing DT ?

>  	{},
>  };
> 
> @@ -471,7 +471,7 @@ static struct spi_driver td028ttec1_spi_driver = {
> 
>  module_spi_driver(td028ttec1_spi_driver);
> 
> -MODULE_ALIAS("spi:toppoly,td028ttec1");
> +MODULE_ALIAS("spi:tpo,td028ttec1");
>  MODULE_AUTHOR("H. Nikolaus Schaller <hns@goldelico.com>");
>  MODULE_DESCRIPTION("Toppoly TD028TTEC1 panel driver");
>  MODULE_LICENSE("GPL");
> diff --git
> a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
> b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c index
> 57e9e146ff74..39e1754746d2 100644
> --- a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
> +++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
> @@ -455,7 +455,7 @@ static int td028ttec1_panel_remove(struct spi_device
> *spi) }
> 
>  static const struct of_device_id td028ttec1_of_match[] = {
> -	{ .compatible = "omapdss,toppoly,td028ttec1", },
> +	{ .compatible = "omapdss,tpo,td028ttec1", },
>  	{},
>  };
> 
> @@ -474,7 +474,7 @@ static struct spi_driver td028ttec1_spi_driver = {
> 
>  module_spi_driver(td028ttec1_spi_driver);
> 
> -MODULE_ALIAS("spi:toppoly,td028ttec1");
> +MODULE_ALIAS("spi:tpo,td028ttec1");
>  MODULE_AUTHOR("H. Nikolaus Schaller <hns@goldelico.com>");
>  MODULE_DESCRIPTION("Toppoly TD028TTEC1 panel driver");
>  MODULE_LICENSE("GPL");


-- 
Regards,

Laurent Pinchart
