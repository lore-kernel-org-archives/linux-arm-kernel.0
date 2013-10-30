From: monstr@monstr.eu (Michal Simek)
Date: Wed, 30 Oct 2013 16:14:04 +0100
Subject: [PATCH] ARM: mm: Fix ECC mem policy printk
In-Reply-To: <20131030150106.GC16735@n2100.arm.linux.org.uk>
References: <8986e8f1a3761e45a7927bdb0e54393c9155e6bf.1383137171.git.michal.simek@xilinx.com>
 <20131030130728.GA16735@n2100.arm.linux.org.uk> <5271165A.4050509@monstr.eu>
 <52711869.60703@monstr.eu> <20131030150106.GC16735@n2100.arm.linux.org.uk>
Message-ID: <5271223C.9090803@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 10/30/2013 04:01 PM, Russell King - ARM Linux wrote:
> On Wed, Oct 30, 2013 at 03:32:09PM +0100, Michal Simek wrote:
>> btw: passing ecc=on through command line will caused that "ECC enabled"
>> message will be there even on systems which don't implement this bit.
>> It is just side effect for both these solutions.
> 
> It is a hint, nothing more.  There is no way to detect whether it's
> implemented or even how it has been implemented.

ok. That's what I wanted to know.


>> Isn't there any easy way to test if this bit is implemented or not just
>> by setting it up and clear it?
> 
> So... let's summerise the message that you're giving.
> 
> "My SoC doesn't implement this bit other than to provide ECC at the L1
> cache, instead implementing a separate ECC scheme for system memory.
> Therefore, I want to change it to describe my implementation, because
> my customers are complaining that it says ECC is disabled when that
> is not the case.  If it can't describe my setup, I want to remove the
> whole facility."
> 
> That's a very selfish attitude.  Sorry, but it would be wrong of me
> to allow your situation to change what we have beyond the proposed
> patch.

I thought the situation is quite clear here. I am just saying
that there is a way to get it back and it is task for us to educate
our users/customers how to get ecc to work on zynq.

> 
> I've shown you the ARM architecture reference manual where this bit in
> the page tables is described, both older and newer versions.  What we're
> doing is in the spirit of the descriptions of bit 9 in the L1 page tables.
> 
> I don't think there's any sensible short description which would
> adequately describe this setting which would satisfy both your situation
> and situations on other SoCs.  We could make the kernel print an entire
> paragraph on it, something like:

It is not my situation and even not my two use cases.
I just want to make sure that if any "user" just use this without knowing
what it means that we will get that message back.
I am not saying it is good or bad. Just saying that there is a way how
to get it back. And the purpose of this second email was just check
that we can't detect that. That's it - nothing more nothing less.

> 
> "ECC might be %sabled.  The exact ECC setting depends on how your SoC
> is implemented.  Please refer to your SoCs technical reference manual
> for a description of bit 9 in the level one page tables for further
> information on how to interpret this statement."
> 
> but that would be idiotic.

I agree with you and none is asking for this.


> Of course, we could just print nothing, but the purpose of printing this
> is so that _we_ as developers looking at the kernel messages know the
> status of this bit, particularly when interpreting oops dumps.  Hiding
> this information would make some oops dumps harder to diagnose.  So...
> this is a matter for user education if your users are complaining about
> it.

I have no problem with that. I just wanted to check that there is no way
how we can detect that. Then your proposed fix is completely fine to me.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131030/286774ef/attachment-0001.sig>
