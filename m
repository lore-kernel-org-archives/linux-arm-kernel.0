From: scott.branden@broadcom.com (Scott Branden)
Date: Mon, 24 Apr 2017 15:50:53 -0700
Subject: [PATCH 1/2] net: dsa: b53: Add compatible strings for the
 Cygnus-family BCM11360.
In-Reply-To: <20170424215022.30382-2-eric@anholt.net>
References: <20170424215022.30382-1-eric@anholt.net>
 <20170424215022.30382-2-eric@anholt.net>
Message-ID: <a2f4f0c9-feea-291b-dae5-f4ed10f9c547@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Minor comment in line

On 17-04-24 02:50 PM, Eric Anholt wrote:
> Cygnus is a small family of SoCs, of which we currently have
> devicetree for BCM11360 and BCM58300.  The 11360's B53 is mostly the
> same as 58xx, just requiring a tiny bit of setup that was previously
> missing.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  Documentation/devicetree/bindings/net/dsa/b53.txt | 3 +++
>  drivers/net/dsa/b53/b53_srab.c                    | 2 ++
>  2 files changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/net/dsa/b53.txt b/Documentation/devicetree/bindings/net/dsa/b53.txt
> index d6c6e41648d4..49c93d3c0839 100644
> --- a/Documentation/devicetree/bindings/net/dsa/b53.txt
> +++ b/Documentation/devicetree/bindings/net/dsa/b53.txt
> @@ -29,6 +29,9 @@ Required properties:
>        "brcm,bcm58625-srab"
>        "brcm,bcm88312-srab" and the mandatory "brcm,nsp-srab string
>
> +  For the BCM11360 SoC, must be:
> +      "brcm,bcm11360-srab" and the mandatory "brcm,cygnus-srab string
> +
place in alphabetical order in the doc?

>    For the BCM63xx/33xx SoCs with an integrated switch, must be one of:
>        "brcm,bcm3384-switch"
>        "brcm,bcm6328-switch"
> diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_srab.c
> index 8a62b6a69703..c37ffd1b6833 100644
> --- a/drivers/net/dsa/b53/b53_srab.c
> +++ b/drivers/net/dsa/b53/b53_srab.c
> @@ -364,6 +364,7 @@ static const struct of_device_id b53_srab_of_match[] = {
>  	{ .compatible = "brcm,bcm53018-srab" },
>  	{ .compatible = "brcm,bcm53019-srab" },
>  	{ .compatible = "brcm,bcm5301x-srab" },
> +	{ .compatible = "brcm,bcm11360-srab", .data = (void *)BCM58XX_DEVICE_ID },
>  	{ .compatible = "brcm,bcm58522-srab", .data = (void *)BCM58XX_DEVICE_ID },
>  	{ .compatible = "brcm,bcm58525-srab", .data = (void *)BCM58XX_DEVICE_ID },
>  	{ .compatible = "brcm,bcm58535-srab", .data = (void *)BCM58XX_DEVICE_ID },
> @@ -371,6 +372,7 @@ static const struct of_device_id b53_srab_of_match[] = {
>  	{ .compatible = "brcm,bcm58623-srab", .data = (void *)BCM58XX_DEVICE_ID },
>  	{ .compatible = "brcm,bcm58625-srab", .data = (void *)BCM58XX_DEVICE_ID },
>  	{ .compatible = "brcm,bcm88312-srab", .data = (void *)BCM58XX_DEVICE_ID },
> +	{ .compatible = "brcm,cygnus-srab", .data = (void *)BCM58XX_DEVICE_ID },
>  	{ .compatible = "brcm,nsp-srab", .data = (void *)BCM58XX_DEVICE_ID },
>  	{ /* sentinel */ },
>  };
>
