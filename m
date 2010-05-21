From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 21 May 2010 13:21:20 +0400
Subject: [PATCH 1/2] s3c2410_wdt - Add extra option to include watchdog
	for	Samsung SoCs
In-Reply-To: <1274353105-17774-2-git-send-email-ben-linux@fluff.org>
References: <1274353105-17774-1-git-send-email-ben-linux@fluff.org>
	<1274353105-17774-2-git-send-email-ben-linux@fluff.org>
Message-ID: <4BF65090.5010905@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Ben Dooks wrote:

> From: Banajit Goswami <banajit.g@samsung.com>

> This patch adds HAVE_S3C2410_WATCHDOG to control inclusion of watchdog driver
> for Samsung SoCs. This option will help to include the driver only for the
> necessary machines and not for all for any given arch.

> Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Acked-by: Ben Dooks <ben-linux@fluff.org>
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
[...]
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 0bf5020..c232146 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -145,13 +145,19 @@ config KS8695_WATCHDOG
>  	  Watchdog timer embedded into KS8695 processor. This will reboot your
>  	  system when the timeout is reached.
>  
> +config HAVE_S3C2410_WATCHDOG
> +	bool
> +	help
> +	  This will include watchdog timer support for Samsung SoCs. If
> +	  you want to include watchdog support for any machine, kindly
> +	  select this in the respective mach-XXXX/Kconfig file.

    What use is the help text for a hidden option?

WBR, Sergei
