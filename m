From: david.yangshuai@gmail.com (David Yang)
Date: Thu, 15 Jul 2010 18:06:22 +0800
Subject: Problem with dma_alloc_coherent at linux-2.6.33-arm1 , with
	RealView platform,board PBX-A9 and armv7 instructions.
In-Reply-To: <20100715095928.GG26212@n2100.arm.linux.org.uk>
References: <AANLkTimtpIQaKVHidWP9fvOKGGiQRc0tne1kO5mO-Zzs@mail.gmail.com>
	<20100715093107.GB17605@trinity.fluff.org>
	<20100715093831.GE26212@n2100.arm.linux.org.uk>
	<AANLkTil1z_o2fBmnw4TljMmu1rbL7hzr0qQDFITs04go@mail.gmail.com>
	<20100715095928.GG26212@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimVUIrwiP3IXR6mfLhfhWOzuKbx_zCgdad9KTVl@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ok,I see .

I will try the patch you offered.

And I will give the results later.

Thanks!

On Thu, Jul 15, 2010 at 5:59 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jul 15, 2010 at 05:56:41PM +0800, David Yang wrote:
>> I have explicitly added the barrier() in my driver, but it did't work.
>
> This imples that you've tried your own solution, which is completely
> different from Catalin's patches.
>
> barrier() is just a compiler barrier, nothing more. ?It won't have any
> effect on external memory ordering. ?It's not surprising this doesn't
> have much effect.
>
