From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 31 May 2011 11:40:57 -0500
Subject: [PATCH] Consolidate the clkdev header files
In-Reply-To: <20110530010416.GA24365@july>
References: <20110530010416.GA24365@july>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F381FC48C2@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, May 29, 2011 6:04 PM, Kyungmin Park wrote:
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Now most of ARM machines has the alsmot same __clk_get/put() macro
> 
> So place it at the arch/arm/include/asm/clkdev.h and remove the reduntant header files
> 
> But some machines don't have the same form as above. It can use the machince specific clkdev file by HAVE_MACH_CLKDEV config
> 
> Now there are only 3 caese.
> 
> 1) define the clk structure with clkdev macro => Need to move clk structure to proper header file
> 
> arch/arm/mach-versatile/include/mach/clkdev.h
> arch/arm/mach-realview/include/mach/clkdev.h
> arch/arm/mach-vexpress/include/mach/clkdev.h
> arch/arm/mach-integrator/include/mach/clkdev.h
> 
> 2) export the __clk_get/put function at clock.c
> 
> arch/arm/mach-shmobile/include/mach/clkdev.h
> 
> 3) demuxing the clk source
> arch/arm/mach-u300/include/mach/clkdev.h
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/Kconfig                             |    6 ++++
>  arch/arm/include/asm/clkdev.h                |    5 ++++

>  arch/arm/mach-ep93xx/include/mach/clkdev.h   |   11 --------

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
