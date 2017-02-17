From: tjakobi@math.uni-bielefeld.de (Tobias Jakobi)
Date: Fri, 17 Feb 2017 16:56:44 +0100
Subject: [PATCH 0/8] ARM: sun8i: a33: Mali improvements
In-Reply-To: <20170217154219.d4z2gylzcrzntlt3@piout.net>
References: <10fd28cb-269a-ec38-ecfb-b7c86be3e716@math.uni-bielefeld.de>
 <20170216184524.cxcy2ux37yrwutla@lukather>
 <2cecfc48-576f-3888-08aa-1fe2edc3c752@math.uni-bielefeld.de>
 <20170217154219.d4z2gylzcrzntlt3@piout.net>
Message-ID: <1c13f7a8-b355-b985-c02f-a50bebfc86a7@math.uni-bielefeld.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexandre Belloni wrote:
> On 17/02/2017 at 13:45:44 +0100, Tobias Jakobi wrote:
>>> The device tree is a representation of the hardware itself. The state
>>> of the driver support doesn't change the hardware you're running on,
>>> just like your BIOS/UEFI on x86 won't change the device it reports to
>>> Linux based on whether it has a driver for it.
>> Like Emil already said, the new bindings and the DT entries are solely
>> introduced to support a proprietary out-of-tree module.
>>
> 
> Because device tree describes the hardware, the added binding doesn't
> support any particular module. The eventually upstreamed drvier will
> share the same bindings.
OK, can we then agree that we _only_ merge the bindings and the entries,
once this driver is upstream?

Driver upstreaming and DT work go hand-in-hand. It's usually after a lot
of discussion that new bindings get finalised. And for that discussion
to happen we need to know how the driver uses the information from the
DT. Otherwise we have no way to evaluate if the description is in any
way "appropriate".

And no, I don't follow the "DT is a separate/independent thing" thought.
It maybe is in an ideal world, but we've seen it now often enough that
bindings turned out to be poorly designed, even though they looked fine
at first.

With best wishes,
Tobias


> 
>> The current workflow when introducing new DT entries is the following:
>> - upstream a driver that uses the entries
>> - THEN add the new entries
>>
> 
> Exactly not, if you do that, checkpatch will complain loudly. Because
> you must not add a driver using bindings that are not documented first.
> 
> 
