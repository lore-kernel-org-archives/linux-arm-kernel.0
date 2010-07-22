From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 22 Jul 2010 10:49:14 +0200
Subject: ARM Machine SoC I/O setup and PAD initialization code
In-Reply-To: <AANLkTilA-9ZjAVqiql1amjjrRlh724z_RHQz7VBdNSxA@mail.gmail.com>
References: <201007211029.29529.david.jander@protonic.nl>
	<20100721084726.GC6009@n2100.arm.linux.org.uk>
	<20100722023250.GC27663@verge.net.au>
	<20100722072034.GA6802@n2100.arm.linux.org.uk>
	<20100722072948.GA7101@verge.net.au>
	<AANLkTilA-9ZjAVqiql1amjjrRlh724z_RHQz7VBdNSxA@mail.gmail.com>
Message-ID: <AANLkTinxKrFdYxfr2X1y9Tkivo3t9Ahz2hNMQDtD7emb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 22, 2010 at 10:38 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Thu, Jul 22, 2010 at 4:29 PM, Simon Horman <horms@verge.net.au> wrote:
>> On Thu, Jul 22, 2010 at 08:20:34AM +0100, Russell King - ARM Linux wrote:
>>> On Thu, Jul 22, 2010 at 11:32:53AM +0900, Simon Horman wrote:
>>> > Would it be feasible to ?use Linux + kexec as the boot loader as
>>> > a long term solution to fixing boot loaders by eliminating them?
>>>
>>> So what you're proposing is that a broken boot loader should boot a
>>> version of Linux to fix the pin MUX, which then kexecs a kernel which
>>> doesn't have that code?
>>>
>>> What's the point of that - when the first kernel will be able to run
>>> the system?
>>
>> Ok, point taken, its impossible to remove the boot loaders.
>
> I disagree. We already use upstream Linux as a boot loader on SuperH.
>
> For ARM and other architectures check out the ELC2010 presentation by
> Greg Ungerer here:
> http://elinux.org/images/7/7b/LinuxWithoutABootLoader.pdf
>
> For SH and a more zoomed our perspective have a look at my presentation:
> http://elinux.org/images/2/2f/ELC-2010-Damm-Kexec.pdf
>

I agree with Magnus, that kernel as a bootloader is a good idea to go.

And the kexecboot works awesome on my zaurus, I like that very much
instead of flashing my device with a series of awkward steps.

Looking into shmobile, there are some specially customized _defconfig
to support that. More _defconfig in ARM might not be a good idea, but I
guess we can solve that in a different way though.
> Cheers,
>
> / magnus
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
