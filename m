From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Fri, 29 Jan 2010 12:56:19 +0300
Subject: [PATCH] ARM: SAMSUNG: Add DMA masks to hsotg device
In-Reply-To: <1264738459-1972-2-git-send-email-ben-linux@fluff.org>
References: <1264738459-1972-1-git-send-email-ben-linux@fluff.org>
	<1264738459-1972-2-git-send-email-ben-linux@fluff.org>
Message-ID: <4B62B0C3.2090705@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Ben Dooks wrote:

> Add the required DMA masks to the hs-otg device definition to allow DMA
> to work with it.
>
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> ---
>  arch/arm/plat-samsung/dev-usb-hsotg.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-samsung/dev-usb-hsotg.c b/arch/arm/plat-samsung/dev-usb-hsotg.c
> index e2f604b..d8b7870 100644
> --- a/arch/arm/plat-samsung/dev-usb-hsotg.c
> +++ b/arch/arm/plat-samsung/dev-usb-hsotg.c
> @@ -33,9 +33,15 @@ static struct resource s3c_usb_hsotg_resources[] = {
>  	},
>  };
>  
> +static u64 s3c_hsotg_dmamask = 0xffffffffUL;
> +
>   

   Shouldn't this be DMA_BIT_MASK(32)?

>  struct platform_device s3c_device_usb_hsotg = {
>  	.name		= "s3c-hsotg",
>  	.id		= -1,
>  	.num_resources	= ARRAY_SIZE(s3c_usb_hsotg_resources),
>  	.resource	= s3c_usb_hsotg_resources,
> +	.dev		= {
> +		.dma_mask		= &s3c_hsotg_dmamask,
> +		.coherent_dma_mask	= 0xffffffffUL,
>   

   Same here...

WBR, Sergei
