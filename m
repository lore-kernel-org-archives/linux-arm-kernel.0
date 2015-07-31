From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Fri, 31 Jul 2015 22:43:54 +0800
Subject: [PATCH v3 4/6] mmc: sdhci-esdhc-imx: add compatible string in
 bingding doc
In-Reply-To: <1438160637-28061-5-git-send-email-haibo.chen@freescale.com>
References: <1438160637-28061-1-git-send-email-haibo.chen@freescale.com>
 <1438160637-28061-5-git-send-email-haibo.chen@freescale.com>
Message-ID: <20150731144354.GC27806@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 29, 2015 at 05:03:55PM +0800, Haibo Chen wrote:
> Add a required property "fsl,imx7d-usdhc" in binding doc.
> Add an optional property "fsl,tuning-step" in binding doc.
> 

Better change to:
mmc: sdhci-esdhc-imx: add imx7d support in bingding doc

> Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> index 211e778..c6624bc 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> @@ -15,6 +15,7 @@ Required properties:
>  	       "fsl,imx6q-usdhc"
>  	       "fsl,imx6sl-usdhc"
>  	       "fsl,imx6sx-usdhc"
> +	       "fsl,imx7d-usdhc"
>  
>  Optional properties:
>  - fsl,wp-controller : Indicate to use controller internal write protection
> @@ -27,6 +28,7 @@ Optional properties:
>    transparent level shifters on the outputs of the controller. Two cells are
>    required, first cell specifies minimum slot voltage (mV), second cell
>    specifies maximum slot voltage (mV). Several ranges could be specified.
> +- fsl,tuning-step: Specify the increasing delay cell steps in tuning procedure.

we could add more explain about this property for better understanding:
e.g. The uSDHC is using one delay cell as default increasing step to do
tuning process. This property allows user to change the tuning step to more
than one delay cells which is useful for some special boards or cards when
the default tuning step can't find the proper delay window within limited
tuning reties.

>  
>  Examples:
>  
> -- 
> 1.9.1
> 

Regards
Dong Aisheng
