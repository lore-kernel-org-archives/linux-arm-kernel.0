From: peter@hurleysoftware.com (Peter Hurley)
Date: Fri, 20 Feb 2015 13:09:58 -0500
Subject: [PATCH 2/4] of: DT quirks infrastructure
In-Reply-To: <20150220164753.GC22752@roeck-us.net>
References: <1424271576-1952-3-git-send-email-pantelis.antoniou@konsulko.com>
 <20150218154106.GC29429@leverpostej>
 <FE61DD1C-51DA-4869-8A62-C019C3D70577@konsulko.com>
 <20150218173115.GG29429@leverpostej>
 <76BD1B22-BAED-4205-9B34-186907CE0217@konsulko.com>
 <54E613E7.2020405@gmail.com>
 <670D0881-DBF0-45E8-A502-A6DB2B77A750@konsulko.com>
 <54E61DD2.3060002@gmail.com>
 <53F2F94C-0C43-4A54-B8CD-EEC454A0AC19@konsulko.com>
 <54E742F2.80506@hurleysoftware.com> <20150220164753.GC22752@roeck-us.net>
Message-ID: <54E77876.9020500@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

On 02/20/2015 11:47 AM, Guenter Roeck wrote:

[...]

> I am open to hearing your suggestions for our use case, where the CPU card with
> the eeprom is manufactured separately from its carier cards.

I think your use case may be more compelling than two flavors of Beaglebone
(one of which is pretty much a dead stick), but it's also less clear what your
design constraints are (not that I really want to know, 'cause I don't).

But the logical extension of this is an N-way dtb that supports unrelated SOCs,
and I think most would agree that's not an acceptable outcome.

My thought was that every design that can afford an EEPROM to probe can afford
a bootloader to select the appropriate dtb, and can afford the extra space
required for multiple dtbs.

I'm not naysaying; I just want to elicit enough information so the community
can make informed decisions.

> I assume you might suggest that manufacturing should (re-)program the EEPROM
> on the CPU card after it was inserted into the carrier.
> 
> Problem is though that the CPU card may be inserted into ts carrier outside
> manufacturing, at the final stages of assembly or in product repair. Those
> groups would typically not even have the means to (re-)program the eeprom.
> Besides, manufacturing would, quite understandably, go ballistic if we demand
> that they start programming EEPROMs after insertion into carrier, and no longer
> use pre-programmed EEPROMs.

I agree; that would be The Wrong Way.

> Note that it is not feasible to put the necessary EEPROM onto the carrier
> either. Maybe in a later design. Maybe that makes sense, and we will go along
> that route at some point. However, forcing a specific hardware solution
> due to software limitations, ie lack of ability by core software to handle
> the different carries, seems to be not the right decision to make on an
> OS level.

Agreed; hardware is what it is.


> In the PCI world it has long since been accepted that the world is not perfect.  
> The argument here is pretty much equivalent to demanding that PCI drop its
> quirks mechanism, to force the HW manufacturers to finally get it right from
> the beginning. I somehow suspect that this won't happen.

I was thinking back to the introductions of fast DEVSEL# and AGP :(

> Instead of questioning the need for a mechanism such as the one proposed by
> Pantelis, I think our time would be better spent arguing if it is the right
> mechanism and, if not, how it can be improved.

My thoughts exactly. Apologies if something I wrote came across as
"You Shall Not Pass" :)

One issue seems to be the moving target that is the compelling use case(s).
The initial submission implied it was the Beaglebone, which comes with
4GB eMMC/microSD so naturally the argument for space-savings with DTBs doesn't
fly. That has since been clarified so no need to rehash that.

Regards,
Peter Hurley
