From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 03 Mar 2012 08:57:27 +0900
Subject: [PATCH v3] ARM: S3C24XX DMA resume regression fix
In-Reply-To: <1330610031-2237-1-git-send-email-dron0gus@gmail.com>
References: <077201ccf767c6d1ec05475c40$%kim@samsung.com>
 <1330610031-2237-1-git-send-email-dron0gus@gmail.com>
Message-ID: <4F515E67.20500@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/01/12 22:53, Gusakov Andrey wrote:
> s3c2410_dma_suspend suspends channels from 0 to dma_channels.
> s3c2410_dma_resume resumes channels in reverse order. So
> pointer should be decremented instead of being incremented.
>
> Signed-off-by: Gusakov Andrey<dron0gus@gmail.com>
> Reviewed-by: Heiko Stuebner<heiko@sntech.de>
> ---
>   arch/arm/plat-s3c24xx/dma.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/plat-s3c24xx/dma.c b/arch/arm/plat-s3c24xx/dma.c
> index 57abec9..16510d5 100644
> --- a/arch/arm/plat-s3c24xx/dma.c
> +++ b/arch/arm/plat-s3c24xx/dma.c
> @@ -1249,7 +1249,7 @@ static void s3c2410_dma_resume(void)
>   	struct s3c2410_dma_chan *cp = s3c2410_chans + dma_channels - 1;
>   	int channel;
>
> -	for (channel = dma_channels - 1; channel>= 0; cp++, channel--)
> +	for (channel = dma_channels - 1; channel>= 0; cp--, channel--)
>   		s3c2410_dma_resume_chan(cp);
>   }
>

Applied, thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
