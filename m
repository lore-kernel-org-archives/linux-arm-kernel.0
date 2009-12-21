From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 21 Dec 2009 12:17:26 +0100
Subject: [PATCH 0/2] mx31moboard for 2.6.33-rc1
In-Reply-To: <1261156293-13981-1-git-send-email-valentin.longchamp@epfl.ch>
References: <1261156293-13981-1-git-send-email-valentin.longchamp@epfl.ch>
Message-ID: <20091221111726.GF15126@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2009 at 06:11:31PM +0100, Valentin Longchamp wrote:
> I have tested mx31moboard with the first -rc. Here are two patches correcting the current problems. They should go to a next -rc.
> 
> 1) The patches for usbh support were based on the bad branch, where
> the platform_devices had been renamed. Now this prevents the mx3
> config to build. The first patch reverts to the correct names.
> 
> 2) The MC13783 voltage regulators with boot_on or always_on enabled
> hang the kernel at boot. Remove these options from mx31moboard
> configuration. Sascha, is this a correct behavior or is it a bug ?

AFAIK the boot_on indicate the regulator framework that this regulator
is already enabled when the kernel starts. I don't see why this makes
the kernel hang. Can you do a bit more debugging please?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
