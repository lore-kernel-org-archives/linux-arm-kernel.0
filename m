From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 Oct 2012 12:05:34 +0000
Subject: [PATCH v3 3/5] zynq: remove use of CLKDEV_LOOKUP
In-Reply-To: <20121024003442.GD31625@beefymiracle.amer.corp.natinst.com>
References: <20121024003442.GD31625@beefymiracle.amer.corp.natinst.com>
Message-ID: <201210241205.34557.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 October 2012, Josh Cartwright wrote:
> The Zynq support in mainline does not (yet) make use of any of the
> generic clk or clk lookup functionality.  Remove what is upstream for
> now, until the out-of-tree implementation is in suitable form for
> merging.
> 
> An important side effect of this patch is that it allows the building of
> a Zynq kernel without running into unresolved symbol problems:
> 
>    drivers/built-in.o: In function `amba_get_enable_pclk':
>    clkdev.c:(.text+0x444): undefined reference to `clk_enable'
>    drivers/built-in.o: In function `amba_remove':
>    clkdev.c:(.text+0x488): undefined reference to `clk_disable'
>    drivers/built-in.o: In function `amba_probe':
>    clkdev.c:(.text+0x540): undefined reference to `clk_disable'
>    drivers/built-in.o: In function `amba_device_add':
>    clkdev.c:(.text+0x77c): undefined reference to `clk_disable'
>    drivers/built-in.o: In function `enable_clock':
>    clkdev.c:(.text+0x29738): undefined reference to `clk_enable'
>    drivers/built-in.o: In function `disable_clock':
>    clkdev.c:(.text+0x29778): undefined reference to `clk_disable'
>    drivers/built-in.o: In function `__pm_clk_remove':
>    clkdev.c:(.text+0x297f8): undefined reference to `clk_disable'
>    drivers/built-in.o: In function `pm_clk_suspend':
>    clkdev.c:(.text+0x29bc8): undefined reference to `clk_disable'
>    drivers/built-in.o: In function `pm_clk_resume':
>    clkdev.c:(.text+0x29c28): undefined reference to `clk_enable'
>    make[2]: *** [vmlinux] Error 1
>    make[1]: *** [sub-make] Error 2
>    make: *** [all] Error 2
> 
> Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> Cc: John Linn <john.linn@xilinx.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

I think I forgot to mention in the previous review round that it would be nice
to just enable CONFIG_COMMON_CLK right away. Not important though.

	Arnd
