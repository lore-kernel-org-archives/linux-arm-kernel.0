From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Thu, 29 Jul 2010 10:49:58 +0200
Subject: [PATCH 3/3] imxfb: add pwmr controlled backlight support
In-Reply-To: <20100729051647.GA11268@pengutronix.de>
References: <1279285747-7860-1-git-send-email-eric@eukrea.com>
	<1279285747-7860-2-git-send-email-eric@eukrea.com>
	<1279285747-7860-3-git-send-email-eric@eukrea.com>
	<20100729051647.GA11268@pengutronix.de>
Message-ID: <4C5140B6.6030703@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Le 29/07/2010 07:16, Uwe Kleine-K?nig a ?crit :
>> Signed-off-by: Eric B?nard<eric@eukrea.com>
>> ---
>> v2 : updated to use backlight infrastructure
> this should have a dependency on CONFIG_BACKLIGHT_CLASS_DEVICE.  As
> Sascha already took your patch you can just try to build mx27_defconfig
> on his for-rmk branch :-|
>
> Instead of a dependency I would prefer to have imxfb usable without
> CONFIG_BACKLIGHT_CLASS_DEVICE.  From a quick look there are drivers that
> have that.  (I checked drivers/video/sa1100fb.c +
> drivers/video/backlight/locomolcd.c.)
>
I've just sent a patch which fixes this build failure with mx27_defconfig.
When CONFIG_BACKLIGHT_CLASS_DEVICE is not selected, the driver is now as 
it was before my patch.

I'll try to put the backligh things in a driver into backlight directory 
when I find time, which will remove the #ifdef

Also, I confirm the patch you sent for 
arch/arm/plat-mxc/include/mach/gpio.h is necessary to compile a kernel 
using mx27_defconfig .

Thanks,
Eric
