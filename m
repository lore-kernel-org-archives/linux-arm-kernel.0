From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Sep 2014 10:40:21 -0700
Subject: [PATCH v8 00/18] 8250-core based serial driver for OMAP + DMA
In-Reply-To: <1409943773-7874-1-git-send-email-bigeasy@linutronix.de>
References: <1409943773-7874-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <20140908174020.GI3238@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140905 12:03]:
> This is my complete queue fo the omap serial driver based on the 8250 core
> code. I played with it on beagle bone, am335x-evm and dra7xx including DMA.
> The runtime-pm pieces look now bug-compatible with the omap-serial driver.
> Besides the runtime-om improvement I also fixed a few corner cases for the
> TX-DMA problem. The DMA fixes (in edma and omap-dma) were dropped and the
> problem has been in 8250-dma via patch #13.
> 
> The whole queue is available at
>   git://git.breakpoint.cc/bigeasy/linux.git uart_v8

Gave the above branch a quick try, but it again does not idle for
my omap3 test cases. It seems that now the cm_idlest1_core sdma
bit is blocking deeper idle states. Is that the correct branch
to use?

Regards,

Tony
