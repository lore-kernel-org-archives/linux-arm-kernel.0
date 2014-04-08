From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 8 Apr 2014 19:44:09 +0800
Subject: [PATCH v12][ 06/12] ARM: dts: imx5*, imx6*: correct
 display-timings nodes.
In-Reply-To: <1396874691-27954-6-git-send-email-denis@eukrea.com>
References: <1396874691-27954-1-git-send-email-denis@eukrea.com>
 <1396874691-27954-6-git-send-email-denis@eukrea.com>
Message-ID: <20140408114407.GB3860@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 07, 2014 at 02:44:45PM +0200, Denis Carikli wrote:
> The imx-drm driver can't use the de-active and
> pixelclk-active display-timings properties yet.
> 
> Instead the data-enable and the pixel data clock
> polarity are hardcoded in the imx-drm driver.
> 
> So theses properties are now set to keep
> the same behaviour when imx-drm will start
> using them.
> 
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
> ChangeLog v9->v10:
> - New patch that was splitted out of:
>   "staging imx-drm: Use de-active and pixelclk-active
>   display-timings."
> ---
>  arch/arm/boot/dts/imx51-babbage.dts       |    2 ++
>  arch/arm/boot/dts/imx53-m53evk.dts        |    2 ++
>  arch/arm/boot/dts/imx53-tx53-x03x.dts     |    2 +-
>  arch/arm/boot/dts/imx6qdl-gw53xx.dtsi     |    2 ++
>  arch/arm/boot/dts/imx6qdl-gw54xx.dtsi     |    2 ++
>  arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi |    2 ++
>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi  |    2 ++
>  arch/arm/boot/dts/imx6qdl-sabrelite.dtsi  |    2 ++
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi    |    2 ++
>  9 files changed, 17 insertions(+), 1 deletion(-)

...

> diff --git a/arch/arm/boot/dts/imx53-tx53-x03x.dts b/arch/arm/boot/dts/imx53-tx53-x03x.dts
> index 0217dde3..4092a81 100644
> --- a/arch/arm/boot/dts/imx53-tx53-x03x.dts
> +++ b/arch/arm/boot/dts/imx53-tx53-x03x.dts
> @@ -93,7 +93,7 @@
>  					hsync-active = <0>;
>  					vsync-active = <0>;
>  					de-active = <1>;
> -					pixelclk-active = <1>;
> +					pixelclk-active = <0>;

@Lothar, is this change correct?

Shawn

>  				};
>  
>  				ET0500 {
