From: ecc@cmu.edu (Eric Cooper)
Date: Sun, 6 Feb 2011 18:24:36 -0500
Subject: more kexec problems on kirkwood
Message-ID: <20110206232436.GD3288@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using a minimal kernel with a built-in initramfs, I've been able to
successfully kexec a ~1M kernel with a ~2.7M initrd.  But if I then
use *that* kernel to try to kexec itself (for example, using "reboot"
when the kexec-tools package is installed), it fails during the
"Uncompressing the kernel" code.

It fails with both gzip and lzma compressed images.  The precise
failure seems to depend on the size of the kernel -- sometimes it
complains about a corrupt image, sometimes it just hangs.  I added
some print statements to the decompress-inflate code, and I've seen
all sorts of error messages.

I then found the same failure-during-decompression occurs if I try to
use the minimal kernel to kexec itself, or the bigger kernel to kexec
anything.

So the successful kexec seems to be a lucky fluke, and there's still
something not set up correctly in the post-kexec environment.

Any suggestions on where to look or how to debug this would be very
welcome.

-- 
Eric Cooper             e c c @ c m u . e d u
