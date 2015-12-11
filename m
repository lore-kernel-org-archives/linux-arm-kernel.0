From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 Dec 2015 13:47:59 +0100
Subject: [PATCH v3 4/4] printk/nmi: Increase the size of NMI buffer and
 make it configurable
In-Reply-To: <20151211124159.GB3729@pathway.suse.cz>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
 <CAMuHMdXVgr58YjoePGrRbMyMncQ27f85prL7G5SpeHeNxoYrXQ@mail.gmail.com>
 <20151211124159.GB3729@pathway.suse.cz>
Message-ID: <10841284.ycX60MmRhF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 December 2015 13:41:59 Petr Mladek wrote:
> diff --git a/init/Kconfig b/init/Kconfig
> index efcff25a112d..61cfd96a3c96 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -870,7 +870,7 @@ config NMI_LOG_BUF_SHIFT
>         int "Temporary per-CPU NMI log buffer size (12 => 4KB, 13 => 8KB)"
>         range 10 21
>         default 13
> -       depends on PRINTK && HAVE_NMI
> +       depends on PRINTK_NMI
>         help
>           Select the size of a per-CPU buffer where NMI messages are temporary
>           stored. They are copied to the main log buffer in a safe context
> 
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

I found this on linux-next as well today and came to the same conclusion.

	Arnd
