From: david.yangshuai@gmail.com (David Yang)
Date: Thu, 15 Jul 2010 19:16:24 +0800
Subject: Problem with dma_alloc_coherent at linux-2.6.33-arm1 , with
	RealView platform,board PBX-A9 and armv7 instructions.
In-Reply-To: <20100715100938.GH26212@n2100.arm.linux.org.uk>
References: <AANLkTimtpIQaKVHidWP9fvOKGGiQRc0tne1kO5mO-Zzs@mail.gmail.com>
	<20100715093107.GB17605@trinity.fluff.org>
	<20100715093831.GE26212@n2100.arm.linux.org.uk>
	<AANLkTil1z_o2fBmnw4TljMmu1rbL7hzr0qQDFITs04go@mail.gmail.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C6087300@dbde02.ent.ti.com>
	<20100715100938.GH26212@n2100.arm.linux.org.uk>
Message-ID: <AANLkTilyVdWrsrDy8tk9_vAxya8o5MSeKJJLEpxjDlSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

patch-6220/1   can't be  patched on kernel version linux-2.6.33-arm1.

the file arch/arm/mm/cache-l2x0.c  may be too old for the patch.


On Thu, Jul 15, 2010 at 6:09 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jul 15, 2010 at 03:34:58PM +0530, Shilimkar, Santosh wrote:
>> > -----Original Message-----
>> > From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
>> > kernel-bounces at lists.infradead.org] On Behalf Of David Yang
>> > Sent: Thursday, July 15, 2010 3:27 PM
>> > To: Russell King - ARM Linux
>> > Cc: linux-arm-kernel at lists.infradead.org; Ben Dooks
>> > Subject: Re: Problem with dma_alloc_coherent at linux-2.6.33-arm1 , with
>> > RealView platform,board PBX-A9 and armv7 instructions.
>> >
>> > I have explicitly added the barrier() in my driver, but it did't work.
>> >
>> > I will go on testing until solve the problem. I need more advice.
>> >
>> The 'barrier()' is just a compiler barrier. You should be using "mb" "rmb"
>> or "wmb" ?depending on the usage.
>
> It'd be useful if the patches which are destined for mainline get some
> independent testing by people who have experienced the problem, rather
> than creating their own solutions.
>
> We can then have much more confidence in the patch which may eventually
> be applied is solving problems people are seeing - and more importantly
> identify any defficiencies in the patch so we don't have to repeatedly
> patch the same area multiple times.
>
