From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 23 Feb 2012 08:45:04 +0100
Subject: [PATCH 2/2] ARM: OMAP: Fix section mismatch warning for
 platform_cpu_die()
In-Reply-To: <1329980310-9007-3-git-send-email-santosh.shilimkar@ti.com>
References: <1329980310-9007-1-git-send-email-santosh.shilimkar@ti.com>
 <1329980310-9007-3-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20120223074504.GZ14173@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Feb 23, 2012 at 12:28:30PM +0530, Santosh Shilimkar wrote:
> WARNING: vmlinux.o(.text+0x226d0):
> Section mismatch in reference from the function
> platform_cpu_die() to the function .cpuinit.text:omap4_hotplug_cpu()
> The function platform_cpu_die() references
> the function __cpuinit omap4_hotplug_cpu().
> This is often because platform_cpu_die lacks a __cpuinit
> annotation or the annotation of omap4_hotplug_cpu is wrong.
> 
> Thanks to Russell King for suggesting __ref annotation trick
> just like it's parent function for this warning becasue __cupinit
s/it's/its/; s/becasue/because/; s/cup/cpu/

Having said that I think the grammar is broken, too. Maybe:

	Thanks to Russell King for suggesting to use __ref instead of
	the initial (and wrong) approach to use __cpuinit.

(But note I'm not a native speaker, too)

Uwe

> usage was definitely wrong to fix this warning..

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
