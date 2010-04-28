From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 28 Apr 2010 03:28:04 +0100
Subject: [PATCH 3/5] S3C: Add S3C2416 detection to uncompress code
In-Reply-To: <1250688667-15639-4-git-send-email-jekhor@gmail.com>
References: <1250688667-15639-1-git-send-email-jekhor@gmail.com>
	<1250688667-15639-2-git-send-email-jekhor@gmail.com>
	<1250688667-15639-3-git-send-email-jekhor@gmail.com>
	<1250688667-15639-4-git-send-email-jekhor@gmail.com>
Message-ID: <20100428022804.GN6684@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 19, 2009 at 04:31:05PM +0300, Yauhen Kharuzhy wrote:
> Add S3C2416 serial port setup to uncompress code.

looks ok.
 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> ---
>  arch/arm/mach-s3c2410/include/mach/uncompress.h |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c2410/include/mach/uncompress.h b/arch/arm/mach-s3c2410/include/mach/uncompress.h
> index c943210..0c431dd 100644
> --- a/arch/arm/mach-s3c2410/include/mach/uncompress.h
> +++ b/arch/arm/mach-s3c2410/include/mach/uncompress.h
> @@ -41,7 +41,9 @@ static void arch_detect_cpu(void)
>  	cpuid &= S3C2410_GSTATUS1_IDMASK;
>  
>  	if (is_arm926() || cpuid == S3C2410_GSTATUS1_2440 ||
> -	    cpuid == S3C2410_GSTATUS1_2442) {
> +	    cpuid == S3C2410_GSTATUS1_2442 ||
> +	    cpuid == S3C2410_GSTATUS1_2416 ||
> +	    cpuid == S3C2410_GSTATUS1_2450) {
>  		fifo_mask = S3C2440_UFSTAT_TXMASK;
>  		fifo_max = 63 << S3C2440_UFSTAT_TXSHIFT;
>  	} else {
> -- 
> 1.6.3.3
> 
> 
> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
