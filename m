From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 23 Oct 2013 12:25:02 -0600
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131023180108.GA23728@roeck-us.net>
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
Message-ID: <20131023182502.GC32563@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 11:01:08AM -0700, Guenter Roeck wrote:
> Not me. We want to be able to run the same kernel on different hardware,
> so we would not want to tie the dtb with the kernel image, but
> the ability to update the dtb on a system when updating the kernel
> is essential. 

This is a really important point.

The complaint from distro-land was they don't want multiple kernel
packages.

What they want is one vmlinux/z, and a package of 'stuff' that they
can assemble a boot image for all hardware out of.

On x86 the package of 'stuff' is modules and grub. Distro scripts
package the modules into the initrd and configure grub based on the
installed hardware to make a bootable image.

On ARM the package of 'stuff' can very reasonably include dtb. Distro
scripts can package modules+DTB+vmlinuz into something the bootloader
can understand. (The next pain point will be to standardize that)

The DTB doesn't have to be 'outside' the distro/kernel to give users a
seamless upgrade experience.

Jason
