From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 7 Jan 2014 09:53:51 +0100
Subject: [PATCH] the eDMA support for the LPUART send driver
In-Reply-To: <0602455564214ab7986348ea985fc820@BL2PR03MB338.namprd03.prod.outlook.com>
References: <1388143449-28640-1-git-send-email-yao.yuan@freescale.com>
 <20140105145031.GB27432@n2100.arm.linux.org.uk>
 <0602455564214ab7986348ea985fc820@BL2PR03MB338.namprd03.prod.outlook.com>
Message-ID: <201401070953.52207.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 January 2014, Yao Yuan wrote:
> Thanks for your suggestion. It's important for me.
> 
> I read the source code for dma_map_single again. I found that both of them(as first argument is
> dma or uart) worked well. But in my code I found that the *sport->port.dev->dma_mask is not
> zero. By contrast the dma_mask for dma device is zero.

Ah, it seems you found two more bugs then ;-)

> You are right. There should be dma device. But I also have a doubt here. Why I find many other
> driver use the first argument here rather than the dma device pointer.

It's a common mistake. Most other linux device driver interfaces require you to pass the
device you are working on, so it's understandable why people come to the wrong conclusion
here.

	Arnd
