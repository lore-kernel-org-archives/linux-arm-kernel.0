From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 2 Jan 2011 23:54:49 +0000
Subject: [PATCH RESEND] [ARM] Add missing include "asm/memory.h"
In-Reply-To: <1293501397.32542.2.camel@mola>
References: <1293501397.32542.2.camel@mola>
Message-ID: <20110102235449.GB17727@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 28, 2010 at 09:56:37AM +0800, Axel Lin wrote:
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
> include/linux/bit_spinlock.h:61: error: implicit declaration of function 'arch_is_coherent'
> make[1]: *** [init/do_mounts_rd.o] Error 1
> make: *** [init] Error 2
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> Acked-by: Peter Huewe <peterhuewe@gmx.de>
> ---
> It was posted on https://lkml.org/lkml/2010/12/17/9 .
> I still have the build error for today's linux-next tree.
> CC Eric Miao, maybe he will take this patch.

Normal practice is to send patches _to_ someone (or some group of people),
and CC interested parties.  (It's even more important with pull requests,
so that the person who should pull knows that's the case.)

Patch is fine, but please throw it into my patch system, thanks.
