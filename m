From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 22 Jul 2010 17:16:17 +0900
Subject: ARM Machine SoC I/O setup and PAD initialization code
In-Reply-To: <20100722072034.GA6802@n2100.arm.linux.org.uk>
References: <201007211029.29529.david.jander@protonic.nl>
	<20100721084726.GC6009@n2100.arm.linux.org.uk>
	<20100722023250.GC27663@verge.net.au>
	<20100722072034.GA6802@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinQS3vkua2dW0iPpXKDJizVIIKgqcBol2FhuRW_@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 22, 2010 at 4:20 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jul 22, 2010 at 11:32:53AM +0900, Simon Horman wrote:
>> Would it be feasible to ?use Linux + kexec as the boot loader as
>> a long term solution to fixing boot loaders by eliminating them?
>
> So what you're proposing is that a broken boot loader should boot a
> version of Linux to fix the pin MUX, which then kexecs a kernel which
> doesn't have that code?

I think Simon was proposing to remove the broken boot loader.

> What's the point of that - when the first kernel will be able to run
> the system?

If you boot straight into a Linux kernel (CONFIG_ZBOOT_ROM on ARM ?)
and use that to boot your real system, then at least you only need one
copy of pinmux setup code. If it gets executed once or twice is a
matter of system configuration IMO.

That aside, not trusting the boot loader is probably a good idea. =)

/ magnus
