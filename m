From: ccross@google.com (Colin Cross)
Date: Tue, 19 Apr 2011 23:48:52 -0700
Subject: how can I cleanly exclude memory from the kernel memory allocator?
In-Reply-To: <20110419233336.GF29359@labbmf-linux.qualcomm.com>
References: <20110324221854.GA29359@labbmf-linux.qualcomm.com>
	<alpine.LFD.2.00.1103241912390.11889@xanadu.home>
	<20110325173928.GD29359@labbmf-linux.qualcomm.com>
	<20110325202755.GA13574@n2100.arm.linux.org.uk>
	<20110419233336.GF29359@labbmf-linux.qualcomm.com>
Message-ID: <BANLkTi=46VZ9Qh621dF9DyWXUHCJPdpV5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2011 at 4:33 PM, Larry Bassel <lbassel@codeaurora.org> wrote:
> On 25 Mar 11 20:27, Russell King - ARM Linux wrote:
>> On Fri, Mar 25, 2011 at 10:39:28AM -0700, Larry Bassel wrote:
>> > OK, please ignore my previous mail, I see that .fixup can be
>> > used to adjust tags. It appears to me, however, that using a
>> > .reserve function calling memblock_reserve will be an
>> > easier way of doing what I need.
>>
>> Absolutely.
>
> Hopefully I'm just missing something obvious, but
> when I call memblock_reserve (in .38) to reserve a block
> of memory away from the general kernel memory pool,
> I find that an ioremap of memory within the reserved block
> still fails because pte_valid() is apparently true.
>
> Is this intended behavior? If so, what would the
> correct way of separating memory from the system be
> so that there is no longer a 1-to-1 1M mapping for
> this memory and ioremap (creating the *only* mapping
> for this memory) is allowed?

You need to call memblock_remove, not memblock_reserve.
