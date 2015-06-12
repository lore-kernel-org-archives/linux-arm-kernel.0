From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 12 Jun 2015 05:23:21 -0700
Subject: [PATCH 2/3] watchdog: bcm2835: Add poweroff code for the Raspberry
 Pi
In-Reply-To: <1433845305-17329-2-git-send-email-noralf@tronnes.org>
References: <1433845305-17329-1-git-send-email-noralf@tronnes.org>
 <1433845305-17329-2-git-send-email-noralf@tronnes.org>
Message-ID: <557ACF39.2060108@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/09/2015 03:21 AM, Noralf Tr?nnes wrote:
> This adds a new poweroff function to the watchdog driver for the
> Raspberry Pi. Currently poweroff/halt results in a reboot.
>
> The Raspberry Pi firmware uses the RSTS register to know which
> partiton to boot from. The partiton value is spread into bits
> 0, 2, 4, 6, 8, 10. Partiton 63 is a special partition used by
> the firmware to indicate halt.
>
> The firmware made this change in 19 Aug 2013 and was matched
> by the downstream commit:
> Changes for new NOOBS multi partition booting from gsh
>
> Signed-off-by: Noralf Tr?nnes <noralf@tronnes.org>

This poweroff handler stuff is getting really messy :-(.

Nothing we can do about that here, so

Acked-by: Guenter Roeck <linux@roeck-us.net>

Guenter
