From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Sep 2016 17:30:49 +0200
Subject: [GIT PULL 4/5] Freescale arm64 device tree updates for 4.9
In-Reply-To: <1473670948-4265-4-git-send-email-shawnguo@kernel.org>
References: <1473670948-4265-1-git-send-email-shawnguo@kernel.org>
 <1473670948-4265-4-git-send-email-shawnguo@kernel.org>
Message-ID: <2241121.MvRjeYAnGC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, September 12, 2016 5:02:27 PM CEST Shawn Guo wrote:
> i.MX arm64 device tree changes for 4.9:
>  - Add property dma-coherent for ls2080a PCI device to save software
>    cache maintenance.
>  - Update serial aliases and use stdout-path to sepecify console for
>    ls2080a and ls1043a boards.
>  - Add DDR memory controller device node for ls2080a and ls1043a SoCs.
> 

Pulled into next/dt64, thanks!

The "dma-coherent" change sounds like a bugfix, should that be backported
to stable kernels? Usually if you lack that property on a device that
is actually coherent, you can get silent data corruption by treating it as
non-coherent.

	Arnd
