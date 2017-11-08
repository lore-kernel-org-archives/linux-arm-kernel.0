From: eric@anholt.net (Eric Anholt)
Date: Wed, 08 Nov 2017 12:41:41 -0800
Subject: [PATCH v2 06/12] hwrng: bcm2835-rng: Rework interrupt masking
In-Reply-To: <1086045224.63286.1510166797078@email.1und1.de>
References: <20171108004449.32730-1-f.fainelli@gmail.com>
 <20171108004449.32730-7-f.fainelli@gmail.com>
 <1086045224.63286.1510166797078@email.1und1.de>
Message-ID: <87efp8bj0a.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi Florian,
>
>> Florian Fainelli <f.fainelli@gmail.com> hat am 8. November 2017 um 01:44 geschrieben:
>> 
>> 
>> The interrupt masking done for Northstart Plus and Northstar (BCM5301X)
>> is moved from being a function pointer mapped to of_device_id::data into
>> a proper part of the hwrng::init callback. While at it, we also make the
>> of_data be a proper structure indicating the platform specifics, since
>> the day we need to add a second type of platform information, we would
>> have to do that anyway.
>
> in the lack of proper documentation for bcm2835 rng, is it possible
> that we should mask the interrupts for bcm2835 as well?

I don't have the RTL nearby and the RNG block doesn't have the usual
#defines for power-on-reset values, so I'm not sure.  I don't see any
use of the RNG by the firmware that should impact Linux -- a driver
exists and it uses IRQs, but it shouldn't have been active, and even if
it was then its teardown process masks the interrupt off again.

However, masking it off ourselves should be harmless at worst.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171108/9fa89f7f/attachment.sig>
