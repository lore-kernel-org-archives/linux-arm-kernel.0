From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Sep 2011 23:34:43 +0200
Subject: [GIT PULL] omap cleanup part1 for v3.2 merge window
In-Reply-To: <20110917014623.GC2937@atomide.com>
References: <20110917014623.GC2937@atomide.com>
Message-ID: <201109202334.43213.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 17 September 2011, Tony Lindgren wrote:
> Hi Arnd,
> 
> Please pull the first part of omap cleanup from:
> 
> git://github.com/tmlind/linux.git cleanup
> 
> This series cleans up early_init functions and removes
> CHIP_IS macro usage. This makes it easier to have SoC
> specific init functions so adding support for new omap
> variants does not require patching all over the place.

One more thing: my randconfig tests are running now and
have spit out a new error after merging lost of stuff
today:

arch/arm/mach-omap2/built-in.o: In function `omap_zoom_init':
/home/arnd/linux-arm/arch/arm/mach-omap2/board-zoom.c:117: undefined reference to `board_nand_init'
make[1]: *** [.tmp_vmlinux1] Error 1
make[1]: Target `_all' not remade because of errors.
make: *** [sub-make] Error 2
make: Target `_all' not remade because of errors.

It's not clear to me if this is actually caused by one of your
changes, or just a mismerge of some sort. I've attached
the defconfig that was used for your reference.

Also, I've got a branch with lots of omap specific randconfig
patches at

git://git.linaro.org/people/arnd/linux.git randconfig/omap

Probably not all of them are correct, but it would be nice
if you could take a look and cherry-pick the ones you like.

	Arnd
-------------- next part --------------
A non-text attachment was scrubbed...
Name: defconfig.gz
Type: application/x-gzip
Size: 2750 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110920/28f35e27/attachment.gz>
