From: marex@denx.de (Marek Vasut)
Date: Sun, 23 Dec 2012 04:20:55 +0100
Subject: [PATCH 2/3] ARM: pxa: palmtreo: fix #ifdefs for leds-gpio device
In-Reply-To: <1356204719-3317-3-git-send-email-mikedunn@newsguy.com>
References: <1356204719-3317-1-git-send-email-mikedunn@newsguy.com>
 <1356204719-3317-3-git-send-email-mikedunn@newsguy.com>
Message-ID: <201212230420.55725.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mike Dunn,

> The #ifdefs around the leds-gpio device platform data are erroneous. 
> Currently the device is not instantiated on the centro unless
> CONFIG_MACH_TREO680 is defined.
> 
> Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
> ---
> 
> The #ifdefs within palmtreo_leds_init() are a little ugly, but I think the
> only alternative would be to instantiate the leds-gpio device platform
> data for both treo680 and centro, which would require some of the #defines
> in palmtreo.h to be moved outside their containing #ifdef
> CONFIG_MACH_{TREO680,CENTRO}.

Shall we not just kill all those ifdefs and let GCC decide what to optimize out? 
I think this kind of simple stuff should just be optimized out anyway.

Best regards,
Marek Vasut
