From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Fri, 08 Jun 2012 11:12:55 +0200
Subject: [PATCH] ARM: iconnect: Remove include of removed
 linux/spi/orion_spi.h
In-Reply-To: <1339145937-24890-1-git-send-email-andrew@lunn.ch> (Andrew Lunn's
 message of "Fri, 8 Jun 2012 10:58:57 +0200")
References: <1339145937-24890-1-git-send-email-andrew@lunn.ch>
Message-ID: <8762b26uaw.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew Lunn <andrew@lunn.ch> writes:

Hi,

> v3.5-rc1 fails to build when DT and iconnect is enabled because of
> this now none existant include file.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/mach-kirkwood/board-iconnect.c |    1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/mach-kirkwood/board-iconnect.c b/arch/arm/mach-kirkwood/board-iconnect.c
> index 2222c57..fa1cbdb 100644
> --- a/arch/arm/mach-kirkwood/board-iconnect.c
> +++ b/arch/arm/mach-kirkwood/board-iconnect.c
> @@ -22,7 +22,6 @@
>  #include <linux/leds.h>
>  #include <linux/spi/flash.h>
>  #include <linux/spi/spi.h>
> -#include <linux/spi/orion_spi.h>
>  #include <linux/i2c.h>
>  #include <linux/input.h>
>  #include <linux/gpio_keys.h>

In fact, you can remove the all the spi-related includes. I have a patch
for that but it has been sleeping on my hard drive. Feel free to resend
a patch with the two other includes removed if you want. Anyway,
whatever you do, you have my ack.

Thanks,
Arnaud
