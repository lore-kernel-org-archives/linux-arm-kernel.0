From: alexander.tarasikov@gmail.com (Alexander Tarasikov)
Date: Tue, 17 Sep 2013 03:21:39 +0400
Subject: RFD on DMA_BIT_MASK and LPAE
In-Reply-To: <20130916230440.GP12758@n2100.arm.linux.org.uk>
References: <CAMChaFwWjxUPzqbwXQqkgeaH4gpdanGF80BBvPBzQ+bVxUcL=g@mail.gmail.com>
 <20130916230440.GP12758@n2100.arm.linux.org.uk>
Message-ID: <CAMChaFwq-Un37KwR0Mx9E9E5-CC-DJH+EEoJdsMAWC7oqff-Ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 3:04 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Sep 17, 2013 at 02:52:28AM +0400, Alexander Tarasikov wrote:
>> Hello, linux hackers!
>>
>> I've tried enabling LPAE (for the purpose of using KVM on A15) and have
>> found out that many drivers break because of the DMA_BIT_MASK. I've found
>> some patches and a discussion on the mailing list, but have not found what
>> the final verdict on the problem was.
>
> The problem is that Linux insists that system memory will start at physical
> address zero.
>
> That is not true on a lot of ARM platforms, especially with LPAE.  This
> assumption needs to be fixed.
>
> I have a large patch series which I posted a few months back - now that
> -rc1 is out, I will be re-posting it and if it gets mostly ignored again,
> I'll drop it into linux-next for more exposure and as a candidiate for
> merging at the next window.

Hello, Russell!
Thanks for the explanation.

>
> Even with LPAE, even with memory all above the 4GB mark, if you have
> 32-bit DMA controllers a 32-bit DMA mask should _still_ work.

Does that mean that the of/platform file (which parses the DTS) will
need no patching
or that it should set the DMA mask based on what the ARM core supports?

Either way, I hope in some time the vanilla linux will be usable
across all those new A15
boards, and you guys have done a fantastic job with migrating to DTS
and moving the
code out of arch/arm. In the meantime, I am happy to use the
vendor-supplied tree
with custom patches because my proof-of-concept KVM port on OMAP5 is working
fine.

-- 
Regards, Alexander
