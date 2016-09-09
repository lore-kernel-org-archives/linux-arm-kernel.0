From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 09 Sep 2016 15:08:45 +0300
Subject: [PATCH 7/8] clocksource: Kconfig: Modify CMT config support 64bit
In-Reply-To: <1473421394-9745-8-git-send-email-bd-phuc@jinso.co.jp>
References: <1473421394-9745-1-git-send-email-bd-phuc@jinso.co.jp>
 <1473421394-9745-8-git-send-email-bd-phuc@jinso.co.jp>
Message-ID: <4193048.IXigyaYqrQ@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bui Duc,

Thank you for the patch.

On Friday 09 Sep 2016 20:43:13 bd-phuc at jinso.co.jp wrote:
> From: Bui Duc Phuc <bd-phuc@jinso.co.jp>
> 
> Modify CMT config to support 64bit
> 
> Signed-off-by: Bui Duc Phuc <bd-phuc@jinso.co.jp>
> ---
>  drivers/clocksource/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 5677886..62c2bcb 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -408,7 +408,7 @@ config SYS_SUPPORTS_EM_STI
>          bool
> 
>  config SH_TIMER_CMT
> -	bool "Renesas CMT timer driver" if COMPILE_TEST
> +	bool "Renesas CMT timer driver" if ( ARM64 || COMPILE_TEST )

I think you should instead add

	select SH_TIMER_CMT

to the config ARCH_RENESAS section in arch/arm64/Kconfig.platforms

>  	depends on GENERIC_CLOCKEVENTS
>  	depends on HAS_IOMEM
>  	default SYS_SUPPORTS_SH_CMT

-- 
Regards,

Laurent Pinchart
