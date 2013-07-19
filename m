From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 19 Jul 2013 15:50:12 +0100
Subject: alignment handler instruction endian-ness
In-Reply-To: <20130719140513.GF24642@n2100.arm.linux.org.uk>
References: <51E91BE5.8070809@codethink.co.uk>
 <20130719110947.GD24642@n2100.arm.linux.org.uk>
 <1374242462.3406.59.camel@linaro1.home>
 <20130719140513.GF24642@n2100.arm.linux.org.uk>
Message-ID: <51E95224.9010306@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/07/13 15:05, Russell King - ARM Linux wrote:
> On Fri, Jul 19, 2013 at 03:01:02PM +0100, Jon Medhurst (Tixy) wrote:
>> On Fri, 2013-07-19 at 12:09 +0100, Russell King - ARM Linux wrote:
>>> On Fri, Jul 19, 2013 at 11:58:45AM +0100, Ben Dooks wrote:
>>>> I ran in to an issue with the alignment handler when running BE8 where
>>>> it loads instructions and fails to swap.
>>>>
>>>> Is there a better way of swapping instructions for ARM when loading
>>>> from arbitrary places? Have I missed any other places this could happen?
>>>
>>> Maybe we need a macro which deals with this automatically?
>>
>> Like the stuff in arch/arm/include/asm/opcodes.h ?
>
> Not like asm/opcodes.h does at the moment, because there's really no
> reason whatsoever that it isn't using the standard swab stuff, which
> will automatically use the rev/rev16 instructions where available.
>
> There's really no reason to open code that stuff.

It seems it is only open coded for the __ASSEMBLY__ version,
it does use swabXX() for the !__ASSEMBLY__ case.

Should we use __mem_to_opcode_arm() in the aligned and abort
handlers?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
