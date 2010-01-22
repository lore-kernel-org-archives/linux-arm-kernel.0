From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 22 Jan 2010 04:24:20 +0000
Subject: [PATCH] hmt: adjust for new pwm_backlight->notify prototype
In-Reply-To: <1264111018-20920-1-git-send-email-jacmet@sunsite.dk>
References: <1264111018-20920-1-git-send-email-jacmet@sunsite.dk>
Message-ID: <20100122042420.GK26562@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 21, 2010 at 10:56:58PM +0100, Peter Korsgaard wrote:
> Commit cfc38999f (backlight: Pass device through notify callback)
> added a struct device argument to the notify callback, but didn't
> update the user of it in mach-hmt.c

applied to for-linus/samsung and in recent pull request.
 
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
> ---
>  arch/arm/mach-s3c6410/mach-hmt.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c6410/mach-hmt.c b/arch/arm/mach-s3c6410/mach-hmt.c
> index cdd4b53..7619456 100644
> --- a/arch/arm/mach-s3c6410/mach-hmt.c
> +++ b/arch/arm/mach-s3c6410/mach-hmt.c
> @@ -82,7 +82,7 @@ static int hmt_bl_init(struct device *dev)
>  	return ret;
>  }
>  
> -static int hmt_bl_notify(int brightness)
> +static int hmt_bl_notify(struct device *dev, int brightness)
>  {
>  	/*
>  	 * translate from CIELUV/CIELAB L*->brightness, E.G. from
> -- 
> 1.6.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
