From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 9 Sep 2016 14:47:37 +0300
Subject: [PATCH 7/8] clocksource: Kconfig: Modify CMT config support 64bit
In-Reply-To: <1473421394-9745-8-git-send-email-bd-phuc@jinso.co.jp>
References: <1473421394-9745-1-git-send-email-bd-phuc@jinso.co.jp>
 <1473421394-9745-8-git-send-email-bd-phuc@jinso.co.jp>
Message-ID: <9b18bc0e-3447-6ab2-3c28-54e54a19dc6f@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/9/2016 2:43 PM, bd-phuc at jinso.co.jp wrote:

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

    Parens not needed and the spaces after/before them even less so.

[...]

MBR, Sergei
