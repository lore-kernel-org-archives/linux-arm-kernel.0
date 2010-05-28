From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sat, 29 May 2010 00:55:37 +0400
Subject: [PATCH v5 1/3] ARM: add CPPI 4.1 DMA support
In-Reply-To: <201005152214.53993.sshtylyov@ru.mvista.com>
References: <201005152214.53993.sshtylyov@ru.mvista.com>
Message-ID: <4C002DC9.1070905@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

I wrote:

> Add support for Texas Instuments Communication Port Programming Interface 4.1
> (CPPI 4.1) used on OMAP-L1x/DA8xx and AM35x.
> 
> At this moment, only the DMA controller and queue manager are supported.
> Support for the buffer manager is lacking but these chips don't have it anyway.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> 
> ---
> Changes since the previous version:
> - moved everything from arch/arm/mach-davinci/ to arch/arm/common/;
> - s/CONFIG_CPPI41/CONFIG_TI_CPPI41/, made that option invisible;
> - added #include <linux/slab.h> for kzalloc();
> - switched alloc_queue() and cppi41_queue_free() to using bit operations;
> - replaced 'static' linking_ram[] by local variable in cppi41_queue_mgr_init();
> - fixed pr_debug() in cppi41_dma_ctrlr_init() to print the real queue manager #.

    I saw no feedback about this patch. Russel, can I put this into your 
patch system?

WBR, Sergei
