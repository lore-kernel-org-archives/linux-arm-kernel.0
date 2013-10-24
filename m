From: a.heider@gmail.com (Andre Heider)
Date: Thu, 24 Oct 2013 14:02:42 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131023182502.GC32563@obsidianresearch.com>
References: <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <52658EBC.8020800@wwwdotorg.org>
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com>
 <20131022150426.GF29341@beef>
 <20131022171346.GE4061@obsidianresearch.com>
 <20131023080630.GA14413@netboy>
 <20131023172955.GA17145@obsidianresearch.com>
 <20131023180108.GA23728@roeck-us.net>
 <20131023182502.GC32563@obsidianresearch.com>
Message-ID: <CAHsu+b-ksO0qaEVpPE1J16T+emgeZTCzdJ9rteNdfBAUUYJY6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 8:25 PM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Wed, Oct 23, 2013 at 11:01:08AM -0700, Guenter Roeck wrote:
>> Not me. We want to be able to run the same kernel on different hardware,
>> so we would not want to tie the dtb with the kernel image, but
>> the ability to update the dtb on a system when updating the kernel
>> is essential.
>
> This is a really important point.
>
> The complaint from distro-land was they don't want multiple kernel
> packages.
>
> What they want is one vmlinux/z, and a package of 'stuff' that they
> can assemble a boot image for all hardware out of.
>
> On x86 the package of 'stuff' is modules and grub. Distro scripts
> package the modules into the initrd and configure grub based on the
> installed hardware to make a bootable image.
>
> On ARM the package of 'stuff' can very reasonably include dtb. Distro
> scripts can package modules+DTB+vmlinuz into something the bootloader
> can understand. (The next pain point will be to standardize that)

There aready is the Boot Loader Specification [0], and the barebox
bootloader supports these specs.

It does exactly what you describe:
After transferring a cross compiled zImage and the corresponding
devicetree I ran the bundled `install-kernel` tool, pointed it to
those files, and it generated the boot entries as described in the
specs.
Upon next boot, the bootloader automagically found the new entry and
offered to boot it via an menu entry. Like grub ;)

[0] http://www.freedesktop.org/wiki/Specifications/BootLoaderSpec/

Regards,
Andre
