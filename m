From: mikpe@it.uu.se (Mikael Pettersson)
Date: Sun, 15 Nov 2009 19:27:33 +0100
Subject: IXP4xx: unneeded #include platform-specific include files?
In-Reply-To: <m3fx8fso72.fsf@intrepid.localdomain>
References: <m3fx8fso72.fsf@intrepid.localdomain>
Message-ID: <19200.18453.644399.845601@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Krzysztof Halasa writes:
 > I wonder about one more thing: why are the platform-specific include
 > files included by the non-platform code?
 > 
 > mach-ixp4xx/include/mach/hardware.h:
 > 
 > /* Platform specific details */
 > #include "ixdp425.h"
 > #include "avila.h"
 > #include "coyote.h"
 > #include "prpmc1100.h"
 > #include "nslu2.h"
 > #include "nas100d.h"
 > #include "dsmg600.h"
 > #include "fsg.h"
 > 
 > I'm going to move them to the platform code, either incorporate them
 > into platform .c files or #include "specific-platform.h" from there.
 > 
 > Objections?

None. Having worked on the Synology DS101 support for mach-ixp4xx
I'm 99,99% certain that platform details can and should be private.

/Mikael
