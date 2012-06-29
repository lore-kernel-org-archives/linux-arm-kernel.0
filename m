From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Jun 2012 11:33:13 +0100
Subject: [BUILD BREAKAGE] versatile, LEDS updates
Message-ID: <20120629103313.GA16319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've just added Versatile to the build system, and the result is not
encouraging.  The integration of the LEDS code into Versatile breaks
its build:

http://www.arm.linux.org.uk/developer/build/result.php?type=build&idx=1281

arch/arm/plat-versatile/leds.c: In function 'versatile_leds_init':
arch/arm/plat-versatile/leds.c:91: error: 'struct led_classdev' has no member named 'trigger_data'

This needs fixing before the LEDS code goes into mainline.

How well tested is the LEDS code?  Was it only tested with a set of
specifically updated configurations (it looks that way to me.)  Was
it ever tested with randconfig?
