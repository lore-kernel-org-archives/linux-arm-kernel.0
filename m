From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 02 Sep 2014 17:46:23 +0200
Subject: [PATCH] tty/serial: fix config dependencies for samsung serial
In-Reply-To: <1409671320-7604-1-git-send-email-ch.naveen@samsung.com>
References: <1409671320-7604-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <3749760.naNt3fHoTI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 September 2014 20:52:00 Naveen Krishna Chatradhi wrote:
> Make the config symbols SERIAL_SAMSUNG_UARTS_4 and
> SERIAL_SAMSUNG_UARTS depend on SERIAL_SAMSUNG rather than
> PLAT_SAMSUNG.

Please always describe why you are doing a change. This patch
seems really pointless.

>  config SERIAL_SAMSUNG_UARTS_4
>         bool
> -       depends on PLAT_SAMSUNG
> +       depends on SERIAL_SAMSUNG
>         default y if !(CPU_S3C2410 || CPU_S3C2412 || CPU_S3C2440 || CPU_S3C2442)
>         help
>           Internal node for the common case of 4 Samsung compatible UARTs
>  
>  config SERIAL_SAMSUNG_UARTS
>         int
> -       depends on PLAT_SAMSUNG
> +       depends on SERIAL_SAMSUNG
>         default 4 if SERIAL_SAMSUNG_UARTS_4 || CPU_S3C2416
>         default 3
>         help
> 

Have you checked that it still builds on all samsung platforms when
SERIAL_SAMSUNG is disabled? We have had build errors in this area
in the past.

	Arnd
