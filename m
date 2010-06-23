From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 23 Jun 2010 08:38:39 +0200
Subject: [PATCH v2 2/4] ARM: S3C2416: Set name of the framebuffer device
	only if it present
In-Reply-To: <1277220124-16225-3-git-send-email-jekhor@gmail.com>
References: <1277220124-16225-1-git-send-email-jekhor@gmail.com>
	<1277220124-16225-3-git-send-email-jekhor@gmail.com>
Message-ID: <002401cb129e$b93a75a0$2baf60e0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday, June 22, 2010 5:22 PM Yauhen Kharuzhy wrote:

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

The above line should be rather removed completely in favor of a
solution proposed by Pawel Osciak in his s3c-fb patches:
http://www.spinics.net/lists/arm-kernel/msg90906.html

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
