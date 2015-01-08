From: horms@verge.net.au (Simon Horman)
Date: Thu, 8 Jan 2015 09:14:12 +0900
Subject: [PATCH v2 0/2] ARM: shmobile: kzm9g: Declare the full 512 MiB of
 RAM
In-Reply-To: <1420571859-11655-1-git-send-email-geert+renesas@glider.be>
References: <1420571859-11655-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20150108001412.GD18943@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 06, 2015 at 08:17:37PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series prepares kzm9g and kzm9g-reference dts for booting a
> multi-platform kernel.
> 
> Traditionally, the first 16 MiB of RAM was reserved for the RT
> processor.  However, this is incompatible with CONFIG_AUTO_ZRELADDR=y,
> which requires that the start address of physical memory is a multiple
> of 128 MiB.
> 
> As CONFIG_AUTO_ZRELADDR=y is enabled for multi-platform kernels, declare
> RAM to start at 0x40000000.
> 
> While at it, reclaim the last 8 MiB of RAM, too, so the full 512 MiB is
> available. We don't know the exact reason why the last 8 MiB of RAM
> was reserved, but thanks to Simon we know it is not used for a U-Boot
> splash screen.  Note that kzm9g_defconfig still has
> CONFIG_MEMORY_START=0x41000000 and CONFIG_MEMORY_SIZE=0x1f000000, so
> before the advent of DT we scribbled over the last 8 MiB, too.
> 
> This is an alternative solution for "[PATCH v2 01/05] ARM: shmobile:
> kzm9g-reference: 0x48008000 load address"
> (http://www.spinics.net/lists/linux-sh/msg38385.html), which
> (a) doesn't loose 112 MiB of RAM, and
> (b) doesn't force to switch from zImage to uImage.
> 
> Thanks for applying!

Thanks, done.
