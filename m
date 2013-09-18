From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Wed, 18 Sep 2013 23:00:13 +0200
Subject: BUG: sleeping function called from invalid context at
 arch/arm/mm/fault.c:301
In-Reply-To: <20130918150730.GU12758@n2100.arm.linux.org.uk> (Russell King's
 message of "Wed, 18 Sep 2013 16:07:30 +0100")
References: <m3mwnaa4sk.fsf@t19.piap.pl>
 <20130918094117.GT12758@n2100.arm.linux.org.uk>
 <m3ioxy9tck.fsf@t19.piap.pl>
 <20130918150730.GU12758@n2100.arm.linux.org.uk>
Message-ID: <m361txu9pe.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> So, in order to find buggy drivers, the IRQ layer will call a shared
> interrupt handler immediately upon registration, and also upon freeing.

Nice, didn't know about that. I will have to check why the bug didn't
manifest itself earlier and/or later (I did rmmod many times and it
fired just once, just after I cut video signal from the camera -
solo6x10 is a audio/video grabber and compressor).
-- 
Krzysztof Halasa
