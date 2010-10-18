From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 18 Oct 2010 21:00:25 +0900
Subject: [PATCH v2 2/4] ARM: S3C2416: Set name of the framebuffer device
	only	if it present
In-Reply-To: <1277220124-16225-3-git-send-email-jekhor@gmail.com>
References: <1277220124-16225-1-git-send-email-jekhor@gmail.com>
	<1277220124-16225-3-git-send-email-jekhor@gmail.com>
Message-ID: <049401cb6ebc$0eb8cc10$2c2a6430$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yauhen Kharuzhy wrote:
> 
> Fix case when board doesn't have LCD connected and doesn't have
> corresponding platform device compiled.
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> ---
>  arch/arm/mach-s3c2416/s3c2416.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c2416/s3c2416.c b/arch/arm/mach-
> s3c2416/s3c2416.c
> index 35dabcc..355ab62 100644
> --- a/arch/arm/mach-s3c2416/s3c2416.c
> +++ b/arch/arm/mach-s3c2416/s3c2416.c
> @@ -90,7 +90,9 @@ int __init s3c2416_init(void)
>  	s3c_i2c0_setname("s3c2440-i2c");
>  	s3c_i2c1_setname("s3c2440-i2c");
> 
> +#ifdef CONFIG_S3C_DEV_FB
>  	s3c_device_fb.name = "s3c2443-fb";
> +#endif

Could you please use s3c_fb_setname() instead?
There is in plat-samsung/include/plat/fb-core.h...

> 
>  	return sysdev_register(&s3c2416_sysdev);
>  }
> --


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
