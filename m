From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 24 Feb 2010 22:34:18 +0000
Subject: [PATCH] Clean up ARM compressed loader
In-Reply-To: <1266978217-7023-1-git-send-email-hector@marcansoft.com>
References: <1266978217-7023-1-git-send-email-hector@marcansoft.com>
Message-ID: <20100224223418.GB25587@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2010 at 03:23:37AM +0100, Hector Martin wrote:
> Instead, clean up the stub loader and unify it. The loader is now
> exactly the same regardless of whether you've enabled CONFIG_ZBOOT_ROM
> or not, and runs from RAM in PIC mode. CONFIG_ZBOOT_ROM simply enables
> an extra section of stub code that lets the zImage boot from ROM by
> copying itself to RAM first.

Unacceptable.

The point of putting the decompressor in ROM is to save the time spent
copying it to RAM first.  Boot loaders are already perfectly capable
of copying the image into RAM and calling it there.

Getting the decompressor to do that step first just moves the copy from
the boot loader into the decompressor.  It doesn't eliminate it, which
is what ROM-based decompression is all about.

Basically, this patch makes the feature entirely pointless.
