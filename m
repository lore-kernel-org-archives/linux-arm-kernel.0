From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Sun, 6 Apr 2014 15:13:18 -0700
Subject: [PATCH] i2c: cadence: fix Kconfig dependency
In-Reply-To: <1396811227-8851-1-git-send-email-wsa@the-dreams.de>
References: <1396811227-8851-1-git-send-email-wsa@the-dreams.de>
Message-ID: <e1274f35-df56-4e76-8e0d-c83a8b59f059@AM1EHSMHS009.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Sun, 2014-04-06 at 09:07PM +0200, Wolfram Sang wrote:
> During development, the driver first really needed to depend on
> COMMON_CLK only. Later, it was switched to writel_relaxed, but it was
> forgotten to update the dependencies, so build errors occured:
> 
> config: make ARCH=i386 allyesconfig
> 
> All error/warnings:
> 
>    drivers/i2c/busses/i2c-cadence.c: In function 'cdns_i2c_clear_bus_hold':
> >> drivers/i2c/busses/i2c-cadence.c:168:3: error: implicit declaration
> >> of function 'writel_relaxed' [-Werror=implicit-function-declaration]
> 
> Use a very safe dependency for now.

Thanks for taking care of this. Looks like the '_relaxed' IO helpers are
only available on ARM. I'll give that a try and might send a patch
eventually. I suspect 'ARM && COMMON_CLK' would work and be a little
less restrictive.

	Thanks,
	S?ren
