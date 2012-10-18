From: b32955@freescale.com (Huang Shijie)
Date: Thu, 18 Oct 2012 16:49:20 +0800
Subject: [PATCH] dma: add new DMA control commands
In-Reply-To: <201210181016.06782.marex@denx.de>
References: <1350538335-29026-1-git-send-email-b32955@freescale.com>
 <201210180914.58527.marex@denx.de> <507FB495.7050104@freescale.com>
 <201210181016.06782.marex@denx.de>
Message-ID: <507FC290.10205@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?10?18? 16:16, Marek Vasut ??:
> So we can't stream data from the chip? About time to adjust the MTD framework to
> allow that. Maybe implement a command queue?
>
IMHO, it's not possible. Because the READ-PAGE(00h-30h) command needs to 
check the busy status
which means we have to stop in the middle, so we can not chain the all 
the read-pages DMA commands.

thanks
Huang Shijie
