From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Apr 2016 16:14:15 +0200
Subject: [GIT PULL] Second Round of Renesas ARM64 Based SoC DT Updates for
 v4.7
In-Reply-To: <cover.1461723181.git.horms+renesas@verge.net.au>
References: <cover.1461723181.git.horms+renesas@verge.net.au>
Message-ID: <1813099.gFLC2Strmj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 April 2016 14:06:43 Simon Horman wrote:
> Second Round of Renesas ARM64 Based SoC DT Updates for v4.7
> 
> * Don't disable referenced optional clocks in DT of r8a7795 SoC
> * Populate EXTALR in DT of salvator-x board
> * Enable PCIe in DT of salvator-x board
> 

Pulled into next/dt64.

I briefly looked at the contents and noticed that the PCIe host
node you add has a dma-ranges property, but its parent node does
not, so you are still limited to 32-bit DMA and you should fix that.

	Arnd
