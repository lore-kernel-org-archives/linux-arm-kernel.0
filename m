From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 30 Jul 2010 19:58:57 +0400
Subject: [PATCH] MTD: pxa2xx: move pxa2xx_flash_probe to .devinit.text
In-Reply-To: <1280504530-31737-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1280504530-31737-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <4C52F6C1.5090207@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig wrote:

> This fixes the following warning by modpost:

> 	WARNING: vmlinux.o(.data+0x15018): Section mismatch in reference from the variable pxa2xx_flash_driver to the function .init.text:pxa2xx_flash_probe()
> 	The variable pxa2xx_flash_driver references
> 	the function __init pxa2xx_flash_probe()
> 	If the reference is valid then annotate the
> 	variable with __init* or __refdata (see linux/init.h) or name the variable:
> 	*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

> I choosed to do this instead of using platform_driver_probe as the remove

    s/choosed/chose/

> function uses __devexit.

    Perhaps remove() method should have been fixed instead -- I doubt that 
this is a hotplug device.

WBR, Sergei
