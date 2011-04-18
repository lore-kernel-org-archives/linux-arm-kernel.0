From: jochen@scram.de (Jochen Friedrich)
Date: Mon, 18 Apr 2011 20:02:05 +0200
Subject: [PATCHv2 2.6.40 2/3] ARM:simpad: Cleanup CS3 accessors.
In-Reply-To: <20110418164911.GF2820@pulham.picochip.com>
References: <1303131636-19442-1-git-send-email-jochen@scram.de>	<1303131636-19442-3-git-send-email-jochen@scram.de>	<20110418134712.GD2820@pulham.picochip.com>	<4DAC4C2E.3050604@scram.de>
	<20110418164911.GF2820@pulham.picochip.com>
Message-ID: <4DAC7C9D.7020304@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jamie,

>> I'll have a look at this. Last time I checked, a single virtual address
>> for a wite-only/read-only register pair was not supported, but this
>> might have changed.
>
> You should just be able to specify a single resource named "dat" and
> you'll be good to go.

Not really. The "CS3" register on the simpad device is a 16bit register
which hat 16 write-only pins and 8 independent read-only pins (no 
direction register, at all). It is implemented using 3 TTL logic chips.
More information about this strange stuff can be found at:
http://opensimpad.org/index.php/Wiring#CS3_latch

I'm not sure if handling such a corner-case in the generic driver makes
sense. However, i'm convinced that moving away from the simpad specific
API to the GPIO API and removing all the platform specific UART and
PCMCIA glue code by a generic GPIO one does make sense, in particular
as the FDT has a nice way to assign GPIO functions to other subsystems.

Thanks,
Jochen
