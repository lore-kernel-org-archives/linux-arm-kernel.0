From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 25 Apr 2012 20:51:24 +0400
Subject: [PATCH 18/33] ARM: S3C24XX: mach-qt2410: Use common macro to
 define resources
In-Reply-To: <1335327163-11794-19-git-send-email-tushar.behera@linaro.org>
References: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
 <1335327163-11794-19-git-send-email-tushar.behera@linaro.org>
Message-ID: <4F982B8C.3050203@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04/25/2012 08:12 AM, Tushar Behera wrote:

> CC: Ben Dooks<ben-linux@fluff.org>
> CC: Kukjin Kim<kgene.kim@samsung.com>
> Signed-off-by: Tushar Behera<tushar.behera@linaro.org>
> ---
>   arch/arm/mach-s3c24xx/mach-qt2410.c |   12 ++----------
>   1 files changed, 2 insertions(+), 10 deletions(-)

> diff --git a/arch/arm/mach-s3c24xx/mach-qt2410.c b/arch/arm/mach-s3c24xx/mach-qt2410.c
> index 91c16d9..b868ddd 100644
> --- a/arch/arm/mach-s3c24xx/mach-qt2410.c
> +++ b/arch/arm/mach-s3c24xx/mach-qt2410.c
> @@ -180,16 +180,8 @@ static struct s3c2410fb_mach_info qt2410_fb_info __initdata = {
>   /* CS8900 */
>
>   static struct resource qt2410_cs89x0_resources[] = {
> -	[0] = {
> -		.start	= 0x19000000,
> -		.end	= 0x19000000 + 16,

    Are you sure there was no mistake here, with - 1 missing? It looks suspicious...

> -		.flags	= IORESOURCE_MEM,
> -	},
> -	[1] = {
> -		.start	= IRQ_EINT9,
> -		.end	= IRQ_EINT9,
> -		.flags	= IORESOURCE_IRQ,
> -	},
> +	[0] = DEFINE_RES_MEM(0x19000000, 17),
> +	[1] = DEFINE_RES_IRQ(IRQ_EINT9),
>   };
>
>   static struct platform_device qt2410_cs89x0 = {

WBR, Sergei
