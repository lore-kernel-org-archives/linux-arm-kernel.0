From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Mon, 10 Aug 2015 16:29:06 +0800
Subject: [PATCH v5 3/6] mmc: sdhci-esdhc-imx: add compatible string in
 bingding doc
In-Reply-To: <1439194688-18335-4-git-send-email-haibo.chen@freescale.com>
References: <1439194688-18335-1-git-send-email-haibo.chen@freescale.com>
 <1439194688-18335-4-git-send-email-haibo.chen@freescale.com>
Message-ID: <20150810082905.GC15036@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 10, 2015 at 04:18:05PM +0800, Haibo Chen wrote:
> Add a required property "fsl,imx7d-usdhc" in binding doc.
> Add an optional property "fsl,tuning-step" in binding doc.
> 
> Signed-off-by: Haibo Chen <haibo.chen@freescale.com>

You missed my former comments.

The patch title is too generous.
Better to change to something like:
mmc: sdhci-esdhc-imx: add imx7d support in bingding doc

Regards
Dong Aisheng

> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> index 211e778..dca56d6 100644
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
> @@ -27,6 +28,11 @@ Optional properties:
>    transparent level shifters on the outputs of the controller. Two cells are
>    required, first cell specifies minimum slot voltage (mV), second cell
>    specifies maximum slot voltage (mV). Several ranges could be specified.
> +- fsl,tuning-step: Specify the increasing delay cell steps in tuning procedure.
> +  The uSDHC use one delay cell as default increasing step to do tuning process.
> +  This property allows user to change the tuning step to more than one delay
> +  cells which is useful for some special boards or cards when the default
> +  tuning step can't find the proper delay window within limited tuning retries.
>  
>  Examples:
>  
> -- 
> 1.9.1
> 
