From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Jan 2017 18:55:50 +0000
Subject: [PATCH] ARM: decompressor: add strlen prototype
In-Reply-To: <20170125222442.1244908-1-arnd@arndb.de>
References: <20170125222442.1244908-1-arnd@arndb.de>
Message-ID: <20170130185550.GG27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2017 at 11:24:33PM +0100, Arnd Bergmann wrote:
> The decompress.c file contains a declaration for strstr() so we can
> include some compression library code.
> 
> With the updated LZ4 implementation, we run into the same problem again
> for strlen():
> 
> In file included from ../include/linux/rcupdate.h:40:0,
>                  from ../include/linux/srcu.h:33,
>                  from ../include/linux/notifier.h:15,
>                  from ../include/linux/memory_hotplug.h:6,
>                  from ../include/linux/mmzone.h:749,
>                  from ../include/linux/gfp.h:5,
>                  from ../include/linux/kmod.h:22,
>                  from ../include/linux/module.h:13,
>                  from ../arch/arm/boot/compressed/../../../../lib/lz4/lz4_decompress.c:39,
>                  from ../arch/arm/boot/compressed/../../../../lib/decompress_unlz4.c:13,
>                  from ../arch/arm/boot/compressed/decompress.c:55:
> include/linux/cpumask.h: In function 'cpumask_parse':
> include/linux/cpumask.h:592:53: error: implicit declaration of function 'strlen';did you mean 'strstr'? [-Werror=implicit-function-declaration]
> 
> This adds another declaration to work around the new problem.
> 
> Fixes: ce83d9ab80d6 ("lib: update LZ4 compressor module")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Please put this in the patch system, thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
