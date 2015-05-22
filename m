From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 May 2015 21:58:56 +0200
Subject: [PATCH] tty: remove platform_sysrq_reset_seq
In-Reply-To: <2397446.P9RRJqoFo7@wuerfel>
References: <2397446.P9RRJqoFo7@wuerfel>
Message-ID: <3075531.er6Vo6bmpE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 May 2015 11:11:28 Arnd Bergmann wrote:
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index 8ba52e56bb8b..9c5395db6a57 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -55,8 +55,7 @@
>  static int __read_mostly sysrq_enabled = CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE;
>  static bool __read_mostly sysrq_always_enabled;
>  
> -unsigned short platform_sysrq_reset_seq[] __weak = { KEY_RESERVED };
> -int sysrq_reset_downtime_ms __weak;
> +static int sysrq_reset_downtime_ms;
>  
>  static bool sysrq_on(void)
>  {
> 

It turns out that the variable is now potentially unused, and we get a warning
when CONFIG_INPUT is disabled. I'll send a fixed v2 of this patch.

	Arnd
