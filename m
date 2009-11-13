From: h.feurstein@gmail.com (Hubert Feurstein)
Date: Fri, 13 Nov 2009 16:16:59 +0100
Subject: ARM: big performance waste in memcpy_{from,to}io
In-Reply-To: <20091113122438.GB29008@n2100.arm.linux.org.uk>
References: <200911121749.49676.h.feurstein@gmail.com>
	<ol1us6-035.ln1@chipmunk.wormnet.eu>
	<200911131232.41716.h.feurstein@gmail.com>
	<20091113122438.GB29008@n2100.arm.linux.org.uk>
Message-ID: <385aa7580911130716l4b43b793ucb9fe7789ee2044f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/11/13 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Fri, Nov 13, 2009 at 12:32:41PM +0100, Hubert Feurstein wrote:
>> The memcpy_{to,from}io-function don't has to care about the bus-width of the
>> attached peripheral, because this is already handled correctly by the static
>> memory controller of your arm-derivate (Of course this one has to be
>> configured correctly to the peripherals bus width). In the rare case where you
>> have to take care about that it is anyway a bad idea to use a memcpy_xxio-
>> function.
>
> I believe there are SoCs where using 32-bit reads on lesser-width buses
> generate faults. ?There are certainly SoCs which do abort reads/writes
> to certain peripherals which aren't the right size.
>
>> Just want to ask the community if there is a really good reason why this
>> bottle neck is still in the ARM kernel?
>
> No one has been bothered for the last 15 years to optimise it.
>

Well, I do, because performance matters.

>> @Russell: What's your opinion on that?
>
> The problem is whether optimising it will end up breaking existing users.
>

Of course you are right, such a change will definitly needs good testing. But
the fear of breaking things should never stop you from improving. Even if it
turns out that the normal good optimized memcpy is not 100% suitable in all
cases there are many other ways of improving memcpy_xxio. IMO a memcpy_xxio
function should be something which uses the power of the architecture,
because it is
used so often. And as my tests showed there is big potential in it.

Regards
Hubert
