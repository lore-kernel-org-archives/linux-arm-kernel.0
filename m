From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 12 Jul 2010 10:14:23 +0200
Subject: TQ2440 problem
In-Reply-To: <AANLkTimQ62x7qhzNj2WDsi6D6XI-H1ayXx4-Hd6dg6Yt@mail.gmail.com>
References: <AANLkTimQ62x7qhzNj2WDsi6D6XI-H1ayXx4-Hd6dg6Yt@mail.gmail.com>
Message-ID: <20100712081423.GC1532@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sat, Jul 10, 2010 at 02:01:19PM +0800, CoffBeta wrote:
> CHK     include/linux/compile.h
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> init/built-in.o: In function `do_one_initcall':
> /home/ymcheng/linux-2.6.27/init/main.c:704: undefined reference to
> `__gnu_mcount_nc'
> init/built-in.o: In function `init_post':
> /home/ymcheng/linux-2.6.27/init/main.c:796: undefined reference to
> `__gnu_mcount_nc'
> init/built-in.o: In function `name_to_dev_t':
> /home/ymcheng/linux-2.6.27/init/do_mounts.c:76: undefined reference to
> `__gnu_mcount_nc'
> init/built-in.o: In function `set_reset_devices':
> /home/ymcheng/linux-2.6.27/init/main.c:183: undefined reference to
> `__gnu_mcount_nc'
> init/built-in.o: In function `debug_kernel':
> /home/ymcheng/linux-2.6.27/init/main.c:234: undefined reference to
> `__gnu_mcount_nc'
> init/built-in.o:/home/ymcheng/linux-2.6.27/init/main.c:240: more undefined
> references to `__gnu_mcount_nc' follow
> make: *** [.tmp_vmlinux1] ?? 1
> 
> why????how can I do it? thanks

Your toolchain is too new for a kernel that old.  You need a kernel
having 181f817eaaca4c1f8a9c265d339d2b96de8b245d.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
