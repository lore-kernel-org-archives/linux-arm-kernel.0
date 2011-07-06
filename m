From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jul 2011 11:22:45 +0100
Subject: [PATCH 0/7] Re-organize linker layouts
Message-ID: <20110706102245.GO8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series of patches are targetted at two issues:

1. Fixing large initramfs causing PC24 relocations to become out of
   range.  This fixes both modules and link-time errors.

2. Making the vmlinux easier to pinpoint the various section-built
   data structures and inspect them later.

For the main kernel, this allows the size of various sections to be
determined via objdump -h.  This also aids objdump -d and -s usage
when asking it to target a particular section.

For the decompressor, it means that it is now trivially possible to copy
out the compressed kernel vmlinux image by:

  arm-linux-objcopy -O binary -j .piggydata arch/arm/boot/compressed/vmlinux \
	piggy.gz

and thereby obtain the binary kernel image (the Image file) which was
originally used.
