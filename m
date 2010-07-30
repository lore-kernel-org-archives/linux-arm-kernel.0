From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 30 Jul 2010 20:51:06 +0200
Subject: [PATCH] MTD: pxa2xx: move pxa2xx_flash_probe to .devinit.text
In-Reply-To: <4C52F6C1.5090207@mvista.com>
References: <1280504530-31737-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<4C52F6C1.5090207@mvista.com>
Message-ID: <20100730185106.GA25446@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 30, 2010 at 07:58:57PM +0400, Sergei Shtylyov wrote:
> Uwe Kleine-K?nig wrote:
>
>> This fixes the following warning by modpost:
>
>> 	WARNING: vmlinux.o(.data+0x15018): Section mismatch in reference from the variable pxa2xx_flash_driver to the function .init.text:pxa2xx_flash_probe()
>> 	The variable pxa2xx_flash_driver references
>> 	the function __init pxa2xx_flash_probe()
>> 	If the reference is valid then annotate the
>> 	variable with __init* or __refdata (see linux/init.h) or name the variable:
>> 	*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,
>
>> I choosed to do this instead of using platform_driver_probe as the remove
>
>    s/choosed/chose/
oh right, thanks.

>> function uses __devexit.
>
>    Perhaps remove() method should have been fixed instead -- I doubt that 
> this is a hotplug device.
Actually I don't care much.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
