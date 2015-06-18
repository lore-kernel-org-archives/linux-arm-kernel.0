From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 17 Jun 2015 20:58:47 -0700
Subject: [PATCH v3] watchdog: bcm2835: Fix poweroff behaviour
In-Reply-To: <1434549844-11704-1-git-send-email-noralf@tronnes.org>
References: <1434549844-11704-1-git-send-email-noralf@tronnes.org>
Message-ID: <558241F7.6070600@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/17/2015 07:04 AM, Noralf Tr?nnes wrote:
> Currently poweroff/halt results in a reboot on the Raspberry Pi.
> The firmware uses the RSTS register to know which partiton to
> boot from. The partiton value is spread into bits
> 0, 2, 4, 6, 8, 10. Partiton 63 is a special partition used by
> the firmware to indicate halt.
>
> The firmware made this change in 19 Aug 2013 and was matched
> by the downstream commit:
> Changes for new NOOBS multi partition booting from gsh
>
> Signed-off-by: Noralf Tr?nnes <noralf@tronnes.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
