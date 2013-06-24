From: gmbnomis@gmail.com (Simon Baatz)
Date: Mon, 24 Jun 2013 18:34:48 +0200
Subject: [Linux 3.10-rc7] at91x40_defconfig build error
In-Reply-To: <1372079648.24001.1.camel@phoenix>
References: <1372079648.24001.1.camel@phoenix>
Message-ID: <20130624163448.GA5087@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Axel,

On Mon, Jun 24, 2013 at 09:14:08PM +0800, Axel Lin wrote:
> Hi,
> I got below build error by "make at91x40_defconfig; make".
> 
>   LD      init/built-in.o
> fs/built-in.o: In function `copy_strings':
> super.c:(.text+0x634c): undefined reference to `flush_kernel_dcache_page'
> super.c:(.text+0x63d4): undefined reference to `flush_kernel_dcache_page'
> lib/built-in.o: In function `sg_miter_stop':
> strnlen_user.c:(.text+0x3394): undefined reference to `flush_kernel_dcache_page'
> make: *** [vmlinux] Error 1
> 
> Any idea to fix this?

Yes, please have a look here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/178271.html

Russell applied the patch to his fixes branch today.

- Simon
