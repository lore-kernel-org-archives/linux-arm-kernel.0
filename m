From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 08 Jul 2011 15:06:17 +0900
Subject: [PATCH 4/4] arm: mach-s3c2440: mini2440: fix section mismatch
In-Reply-To: <1310033919-4245-5-git-send-email-w.sang@pengutronix.de>
References: <1310033919-4245-1-git-send-email-w.sang@pengutronix.de>
	<1310033919-4245-5-git-send-email-w.sang@pengutronix.de>
Message-ID: <001c01cc3d35$2aa7e8f0$7ff7bad0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wolfram Sang wrote:
> 
> If mini2440_init() is in __init, mini2440_parse_features() should also
> be in __init. Fixes:
> 
> (.text+0x9adc): Section mismatch in reference from the function
> mini2440_parse_features.clone.0() to the (unknown reference)
.init.data:(unknown)
> The function mini2440_parse_features.clone.0() references the (unknown
reference)
> __initdata (unknown).

But I couldn't find above "Section mismatch" in my building with
CONFIG_DEBUG_SECTION_MISMATCH=y.

Hmm...

> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Michel Pollet <buserror@gmail.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-s3c2440/mach-mini2440.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c2440/mach-mini2440.c b/arch/arm/mach-
> s3c2440/mach-mini2440.c
> index dd3120d..fc2dc0b 100644
> --- a/arch/arm/mach-s3c2440/mach-mini2440.c
> +++ b/arch/arm/mach-s3c2440/mach-mini2440.c
> @@ -552,7 +552,7 @@ struct mini2440_features_t {
>  	struct platform_device *optional[8];
>  };
> 
> -static void mini2440_parse_features(
> +static void __init mini2440_parse_features(
>  		struct mini2440_features_t * features,
>  		const char * features_str )
>  {
> --
> 1.7.5.4

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
