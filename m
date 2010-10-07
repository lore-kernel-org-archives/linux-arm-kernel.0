From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 07 Oct 2010 10:29:44 +0900
Subject: [PATCH 3/7] ARM: Samsung: Use the correct I2C2 interrupt
In-Reply-To: <20100930044832.GA16905@july>
References: <20100930044832.GA16905@july>
Message-ID: <004301cb65bf$225c62f0$671528d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Use the correct I2C2 interrupt.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/plat-samsung/dev-i2c2.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/dev-i2c2.c
b/arch/arm/plat-samsung/dev-i2c2.c
> index 07036de..ff4ba69 100644
> --- a/arch/arm/plat-samsung/dev-i2c2.c
> +++ b/arch/arm/plat-samsung/dev-i2c2.c
> @@ -32,8 +32,8 @@ static struct resource s3c_i2c_resource[] = {
>  		.flags = IORESOURCE_MEM,
>  	},
>  	[1] = {
> -		.start = IRQ_CAN0,
> -		.end   = IRQ_CAN0,
> +		.start = IRQ_IIC2,
> +		.end   = IRQ_IIC2,
>  		.flags = IORESOURCE_IRQ,
>  	},
>  };
> --

Hi,

Looks ok...
In my opinion, could you please merge your 2nd and this patch to one,
changing I2C2 interrupt name?
And need to add s5pc100's I2C2 interrupt name changing in there.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
