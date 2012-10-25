From: klightspeed@killerwolves.net (Ben Peddell)
Date: Thu, 25 Oct 2012 18:06:56 +1000
Subject: RFC: tolerate junk after valid initramfs
Message-ID: <5088F320.6000806@killerwolves.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the moment, the initramfs handling code will reject a valid initramfs
if there is junk between the end of the valid initramfs and the
initramfs size given to the kernel.

For example passing initrd=0x01000000,4M will not work unless the
initramfs is either exactly 4M in size or is padded with zeroes up to 4M.

As those working with ARM processors might know, the initialization code
in the bootloader generally doesn't zero out unused memory, so that
memory will contain garbage.

What downsides are there to patching init/initramfs.c to have the kernel
accept valid initramfs images where the image is shorter than the length
passed to the kernel by the bootloader?
