From: PeterHuewe@gmx.de (Peter Huewe)
Date: Sun, 19 Dec 2010 20:16:48 +0100
Subject: [PATCH] [ARM] Add missing include "asm/memory.h"
In-Reply-To: <1292566109.21261.1.camel@mola>
References: <1292566109.21261.1.camel@mola>
Message-ID: <201012192016.49026.PeterHuewe@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag 17 Dezember 2010, 07:08:29 schrieb Axel Lin:
> This patch fixes below build error by adding the missing asm/memory.h,
> which is needed for arch_is_coherent().
> 
> $ make pxa3xx_defconfig; make
>   CC      init/do_mounts_rd.o
> In file included from include/linux/list_bl.h:5,
>                  from include/linux/rculist_bl.h:7,
>                  from include/linux/dcache.h:7,
>                  from include/linux/fs.h:381,
>                  from init/do_mounts_rd.c:3:
> include/linux/bit_spinlock.h: In function 'bit_spin_unlock':
> include/linux/bit_spinlock.h:61: error: implicit declaration of function
> 'arch_is_coherent' make[1]: *** [init/do_mounts_rd.o] Error 1
> make: *** [init] Error 2
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Looks good - compiles fine on
arm (hackkit_defconfig and ep93xx_defconfig), 

Acked-by: Peter Huewe <peterhuewe@gmx.de>
