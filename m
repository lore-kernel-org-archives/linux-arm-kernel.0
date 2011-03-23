From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Wed, 23 Mar 2011 13:05:04 +0000
Subject: multiple definition of show_mem for pxa
Message-ID: <4D89F000.1070509@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all

Can't immediately track down what changed to cause this issue, but
building with current mainline is giving me:

lib/lib.a(show_mem.o): In function `show_mem':
show_mem.c:(.text+0x13c): multiple definition of `show_mem'
arch/arm/mm/built-in.o:copypage-xscale.c:(.text+0xfcc): first defined here
make: *** [vmlinux.o] Error 1


Anyone know what caused this?

There are indeed two versions of mem_info, the generic one and one
in arch/arm/mm/init.c but I think they have both been around for
some time without issue.

Thanks,

Jonathan
