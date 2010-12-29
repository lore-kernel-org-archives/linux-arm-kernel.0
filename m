From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 29 Dec 2010 12:37:40 -0800
Subject: (arm-)global platform device registration functions
In-Reply-To: <20101229162512.GI14221@pengutronix.de>
References: <20101229162512.GI14221@pengutronix.de>
Message-ID: <20101229123740.c39238f8.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 29 Dec 2010 17:25:12 +0100
Uwe Kleine-K__nig <u.kleine-koenig@pengutronix.de> wrote:

> Hello,
> 
> some time ago I started to dynamically allocate platform_devices for
> arm/plat-mxc.  For that purpose I added many functions, see
> arch/arm/plat-mxc/include/mach/devices-common.h [1].  Now arm/arch-mxs
> want to do the same, so I wonder if it would be sensible to do something
> like this more globally (either for arm or better kernel global).
> 

Sounds sensible to me, although I don't really understand what you've
done - didn't platform_device_alloc() already "dynamically allocate
platform_devices"?

If you were to implement this common infrastructure, there may be
already-existing code which could use it.  How would we locate that?
