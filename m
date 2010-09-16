From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 16 Sep 2010 08:48:23 -0700
Subject: [PATCH 1/4] OMAP: introduce OPP layer for device-specific OPPs
In-Reply-To: <4C92386F.2070600@ti.com> (Nishanth Menon's message of "Thu, 16
	Sep 2010 10:31:59 -0500")
References: <1284587799-9637-1-git-send-email-khilman@deeprootsystems.com>
	<1284587799-9637-2-git-send-email-khilman@deeprootsystems.com>
	<AANLkTimC9NOJ5TSqkb1ekBQ_ei2-Ci2ewL66+4aCnyk=@mail.gmail.com>
	<87sk19eneu.fsf@deeprootsystems.com> <4C92386F.2070600@ti.com>
Message-ID: <87vd65bsfs.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nishanth Menon <nm@ti.com> writes:

> Kevin Hilman had written, on 09/16/2010 10:08 AM, the following:
> [..]
>>> more than that you name
>>> some functions omap_*, and how hard would it be to put it under
>>> arch/arm/common/*.c
>>> arch/arm/include/asm/*.h
>>>
>>> Possible even higher up in the directory hiearchy in include/linux/opp.h
>>> for the header and drivers/opp/*.c, because I think SuperH and power
>>> are not that different in this respect.
>>
>> Yeah, I guess this isn't ARM specific either, so should be at a higher
>> level. 
>>
>> Nishanth, can take my hack below and continue this evolution?  As I
>> demonstrate with this hack, this won't really change anything for us.
>
> thanks..  The only contention ahead is: where do we want this?
> Is drivers/opp/opp_core.c the right place? Given that this is just a
> support library and not really a driver? for some reason lib/opp.c
> does'nt sound just right either :(

Well, since it's not really a driver, I don't think drivers/* is
appropriate.

lib/opp/* seems more appropriate to me with the header at
include/linux/opp.h as Linus suggested.

Kevin
