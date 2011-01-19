From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 19 Jan 2011 14:55:01 +0000
Subject: RFC: Host-endian device tree format
In-Reply-To: <AANLkTikoZj1WSpE8QNSRiF3oFL4qAb68kNnCKdExvBz7@mail.gmail.com>
References: <AANLkTi=AdwaW5vvm1TzNxcNrjYiJ3dOEjwoZrm-koxuw@mail.gmail.com>
	<AANLkTikoZj1WSpE8QNSRiF3oFL4qAb68kNnCKdExvBz7@mail.gmail.com>
Message-ID: <AANLkTi=xdJ_c3LvCFkeqBRNDf6TSC40Fjxihm9eSeMmf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 19, 2011 at 1:41 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
>
> On Jan 19, 2011 3:43 AM, "Dave Martin" <dave.martin@linaro.org> wrote:
>>
>> Hi all,
>>
>> Apologies if this has been discussed before--- I don't see an obvious
>> rebuttal in my quick searching past threads, so I'll just quickly ask
>> the question:
>>
>> Could we use host-endianness for the device tree binary blob?
>
> Hi David.
>
> This has been discussed thoroughly and rejected.

I thought this may have been the case...

> The dtb isn't so much bigendian as it is network byte order.

(For me, "network byte order" is a euphemism ... <insert
unconstructive rant here>)

However I digress... it sounds like you are familiar with the
arguments I would make, and I'm not trying to get into an endianness
war ;)

> While we /could/ switch it for arm,
> it creates all kinds of problems with tools and working with .dtb files on
> dissimilar platforms.? Plus all the property values must remain in BE
> because all the bindings are already defined that way in the OpenFirmware
> specifications.

OK, agreed -- I guess I might have specified it differently :)  But
since the specs are already written and can't be supplemented without
causing disruption, I guess attempting changes may be more trouble
than it's worth.

>
> Besides, there is no real advantage to changing it: it already works as-is
> on le architectures.? :-)

I'm happy to go along with it if nobody sees a benefit in changing
it... the status quo is what it is.

Just wanted to know whether anyone cared / whether an opportunity was
being missed, given that the newness of this stuff on ARM could
present an opportunity.

If this is not the case then that's fine by me.

Cheers
---Dave
