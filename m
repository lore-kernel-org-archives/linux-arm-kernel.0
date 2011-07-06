From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 06 Jul 2011 11:09:44 -0400 (EDT)
Subject: [PATCH 0/7] Re-organize linker layouts
In-Reply-To: <20110706102245.GO8286@n2100.arm.linux.org.uk>
References: <20110706102245.GO8286@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1107061108240.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Jul 2011, Russell King - ARM Linux wrote:

> The following series of patches are targetted at two issues:
> 
> 1. Fixing large initramfs causing PC24 relocations to become out of
>    range.  This fixes both modules and link-time errors.
> 
> 2. Making the vmlinux easier to pinpoint the various section-built
>    data structures and inspect them later.
> 
> For the main kernel, this allows the size of various sections to be
> determined via objdump -h.  This also aids objdump -d and -s usage
> when asking it to target a particular section.
> 
> For the decompressor, it means that it is now trivially possible to copy
> out the compressed kernel vmlinux image by:
> 
>   arm-linux-objcopy -O binary -j .piggydata arch/arm/boot/compressed/vmlinux \
> 	piggy.gz
> 
> and thereby obtain the binary kernel image (the Image file) which was
> originally used.

Looks good.  For the whole series:

Acked-by: nicolas Pitre <nicolas.pitre@linaro.org>


Nicolas
