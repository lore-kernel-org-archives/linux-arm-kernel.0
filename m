From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 27 Apr 2015 15:32:08 +0200
Subject: [PATCH 2/2] ARM: BCM2835: Move the restart/power_off handling to
 the WDT driver.
In-Reply-To: <553E398E.7060305@roeck-us.net>
References: <1429902534-2348-1-git-send-email-eric@anholt.net>
 <2465337.STuvDNQht6@wuerfel> <553E398E.7060305@roeck-us.net>
Message-ID: <17452307.kZG5bCi4C8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 27 April 2015 06:28:46 Guenter Roeck wrote:
> >
> 
> The pointer to the power-off handler is removed in the device remove callback,
> and thus won't be called after the device is unbound.
> 
> Ultimately this is similar the the current code, which assumes that the
> call to of_find_device_by_node(np) never fails.
> 

Ok, I missed that part. Yes, that works just as well.

	Arnd
