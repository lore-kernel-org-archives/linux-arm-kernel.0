From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 May 2013 17:10:23 +0200
Subject: [PATCH] USB: set device dma_mask without reference to global data
In-Reply-To: <Pine.LNX.4.44L0.1305081011480.1450-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1305081011480.1450-100000@iolanthe.rowland.org>
Message-ID: <201305081710.23489.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 May 2013, Alan Stern wrote:
> > The first occurence was apparently in 3.3, but only in ehci-tegra.c,
> > while the other drivers subsequently copied the bug.
> 
> An alternative solution -- perhaps not better but also not relying on
> coherent_dma_mask -- is to clear pdev->dev.dma_mask in the remove
> routine if it points to the static mask value.
> 

Yes, I thought about that, but couldn't see any advantage one way
or the other and this one seemed simpler.

	Arnd
