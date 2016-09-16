From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 16 Sep 2016 09:47:03 +0800
Subject: [GIT PULL 4/5] Freescale arm64 device tree updates for 4.9
In-Reply-To: <2241121.MvRjeYAnGC@wuerfel>
References: <1473670948-4265-1-git-send-email-shawnguo@kernel.org>
 <1473670948-4265-4-git-send-email-shawnguo@kernel.org>
 <2241121.MvRjeYAnGC@wuerfel>
Message-ID: <20160916014703.GC7398@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2016 at 05:30:49PM +0200, Arnd Bergmann wrote:
> On Monday, September 12, 2016 5:02:27 PM CEST Shawn Guo wrote:
> > i.MX arm64 device tree changes for 4.9:
> >  - Add property dma-coherent for ls2080a PCI device to save software
> >    cache maintenance.
> >  - Update serial aliases and use stdout-path to sepecify console for
> >    ls2080a and ls1043a boards.
> >  - Add DDR memory controller device node for ls2080a and ls1043a SoCs.
> > 
> 
> Pulled into next/dt64, thanks!
> 
> The "dma-coherent" change sounds like a bugfix, should that be backported
> to stable kernels? Usually if you lack that property on a device that
> is actually coherent, you can get silent data corruption by treating it as
> non-coherent.

My impression is that those cache maintenance enforced for non-coherent
device will hurt performance on coherent device.  I don't know it will
cause data corruption.

@Liu Gang,

Did you experience any functional issue with PCI device before adding
"dma-coherent" property?  If not, can you please do more testing to
confirm this is only about performance?  Otherwise, you should follow
Arnd's suggestion to send the change for stable kernel.

Shawn
