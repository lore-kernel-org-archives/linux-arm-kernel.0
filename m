From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 19 Jul 2013 12:26:24 +0100
Subject: alignment handler instruction endian-ness
In-Reply-To: <20130719110947.GD24642@n2100.arm.linux.org.uk>
References: <51E91BE5.8070809@codethink.co.uk>
 <20130719110947.GD24642@n2100.arm.linux.org.uk>
Message-ID: <51E92260.1060101@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/07/13 12:09, Russell King - ARM Linux wrote:
> On Fri, Jul 19, 2013 at 11:58:45AM +0100, Ben Dooks wrote:
>> I ran in to an issue with the alignment handler when running BE8 where
>> it loads instructions and fails to swap.
>>
>> Is there a better way of swapping instructions for ARM when loading
>> from arbitrary places? Have I missed any other places this could happen?
>
> Maybe we need a macro which deals with this automatically?
>
> 	arm_instr_to_cpu(x)
> 	thumb_instr_to_cpu(x)
>
> These should probably make use of the swab*() macros when an endian swap
> is needed.
>
>> The following patch is my first attempt at solving the problem for the
>> alignment handler:
>
> I'd suggest checking this with sparse too - you have some type errors here.

Very probably, I needed this in a hurry and was after some input on how
it could be improved.

The only issue I was thinking of for having those functions would be if
the userspace was running BE32 and the kernel was LE. I don't think this
is very likely, so it can probably be discounted.

I could not find where the kernel's relocation code does this to see if
it also needed changing.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
