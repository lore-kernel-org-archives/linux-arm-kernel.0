From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Thu, 25 Mar 2010 19:05:47 +0900
Subject: [PATCH v2] PL330: Add PL330 DMA controller driver
In-Reply-To: <960f4547118a62d5863ee38ba760844c@localhost>
References: <4BAAD5BB.7050101@samsung.com>
	<20100325054430.165311fa@taxman.wild-wind.fr.eu.org>
	<4BAB264C.2090502@samsung.com>
	<960f4547118a62d5863ee38ba760844c@localhost>
Message-ID: <4BAB357B.7040108@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/25/2010 6:32 PM, Marc Zyngier wrote:
> On Thu, 25 Mar 2010 18:01:00 +0900, Joonyoung Shim
> <jy0922.shim@samsung.com> wrote:
>> On 3/25/2010 2:44 PM, Marc Zyngier wrote:
>>> On Thu, 25 Mar 2010 12:17:15 +0900
>>> Joonyoung Shim <jy0922.shim@samsung.com> wrote:
>>>
>>>> +	writew(imm, desc_pool_virt);
>> Right. The write[bwl] is api for address ioremapped of io device. I will
>> change these.
>>
>>> Does anything ensure that this won't generate an unaligned access?
>>>
>> PL330 DMA controller fetches variable length instructions that consist
> of
>> one to six bytes, so i think unaligned access is no problem.
> 
> I'm not too concerned about the device side of things. I'm more worried
> about the CPU access when writing the 'imm' value to memory.
> 
> Consider desc_pool_virt 16bit aligned when entering the function. Writing
> the opcode makes it unaligned and then writing the 'imm' value will result
> as an unaligned access.
> 

Why desc_pool_virt should be aligned more than 16bit?
