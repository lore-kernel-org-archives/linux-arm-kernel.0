From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 17 Jul 2015 14:32:08 -0700
Subject: [PATCH v2] input: snvs_pwrkey: use "wakeup-source" as deivce
 tree property name
In-Reply-To: <1437105737-16899-1-git-send-email-shawnguo@kernel.org>
References: <1437105737-16899-1-git-send-email-shawnguo@kernel.org>
Message-ID: <20150717213208.GB39282@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 17, 2015 at 12:02:17PM +0800, Shawn Guo wrote:
> Instead of inventing a new property name, let's use "wakeup-source" to
> be consistent with other driver and subsystem bindings.
> 
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> ---
> Changes since v1:
>  - Use "wakeup-source" rather than "linux,wakeup"
> 
> This is a fixup for Frank's patch which is queued on i.MX tree, so I
> will apply it to the same branch.

So we do not need to care about keeping compatibility yet. Good.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> 
> Shawn
> 
>  Documentation/devicetree/bindings/crypto/fsl-sec4.txt | 2 +-
>  drivers/input/keyboard/snvs_pwrkey.c                  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> index 71a39c5bd486..f16bbd6644b8 100644
> --- a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> +++ b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> @@ -408,7 +408,7 @@ System ON/OFF key driver
>        Value type: <int>
>        Definition: Keycode to emit, KEY_POWER by default.
>  
> -  - wakeup:
> +  - wakeup-source:
>        Usage: option
>        Value type: <boo>
>        Definition: Button can wake-up the system.
> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
> index 512a1fc2a864..78fd24ca3813 100644
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
> @@ -122,7 +122,7 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>  		dev_warn(&pdev->dev, "KEY_POWER without setting in dts\n");
>  	}
>  
> -	pdata->wakeup = of_property_read_bool(np, "wakeup");
> +	pdata->wakeup = of_property_read_bool(np, "wakeup-source");
>  
>  	pdata->irq = platform_get_irq(pdev, 0);
>  	if (pdata->irq < 0) {
> -- 
> 1.9.1
> 

-- 
Dmitry
