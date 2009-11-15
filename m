From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sun, 15 Nov 2009 18:16:49 +0100
Subject: IXP4xx: unneeded #include platform-specific include files?
Message-ID: <m3fx8fso72.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I wonder about one more thing: why are the platform-specific include
files included by the non-platform code?

mach-ixp4xx/include/mach/hardware.h:

/* Platform specific details */
#include "ixdp425.h"
#include "avila.h"
#include "coyote.h"
#include "prpmc1100.h"
#include "nslu2.h"
#include "nas100d.h"
#include "dsmg600.h"
#include "fsg.h"

I'm going to move them to the platform code, either incorporate them
into platform .c files or #include "specific-platform.h" from there.

Objections?
-- 
Krzysztof Halasa
