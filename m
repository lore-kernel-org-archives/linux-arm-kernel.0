From: olof@lixom.net (Olof Johansson)
Date: Fri, 21 Sep 2012 22:29:04 -0700
Subject: [GIT PULL V3 1/5] ARM: Kirkwood: address decoding change for v3.7
In-Reply-To: <20120921194141.GV5469@titan.lakedaemon.net>
References: <20120829001129.GO19437@titan.lakedaemon.net>
 <20120921194141.GV5469@titan.lakedaemon.net>
Message-ID: <20120922052904.GC32245@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 03:41:41PM -0400, Jason Cooper wrote:
> The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:
> 
>   Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)
> 
> are available in the git repository at:
>   git://git.infradead.org/users/jcooper/linux.git kirkwood/addr_decode
> 
> Thomas Petazzoni (17):
>       arm: mach-dove: use plus instead of or for address definitions
>       arm: mach-kirkwood: use plus instead of or for address definitions
>       arm: mach-mv78xx0: use plus instead of or for address definitions
>       arm: mach-orion5x: use plus instead of or for address definitions
>       arm: mach-dove: use IOMEM() for base address definitions
>       arm: mach-kirkwood: use IOMEM() for base address definitions
>       arm: mach-mv78xx0: use IOMEM() for base address definitions
>       arm: mach-orion5x: use IOMEM() for base address definitions
>       arm: mach-mvebu: use IOMEM() for base address definitions
>       arm: plat-orion: use void __iomem pointers for UART registration functions
>       arm: plat-orion: use void __iomem pointers for MPP functions
>       arm: plat-orion: use void __iomem pointers for time functions
>       arm: plat-orion: use void __iomem pointers for addr-map functions
>       arm: plat-orion: introduce PLAT_ORION_LEGACY hidden config option
>       arm: plat-orion: make bridge_virt_base non-const to support DT use case
>       arm: mvebu: add basic address decoding support to Armada 370/XP
>       arm: mvebu: add address decoding controller to the DT

Hi,

This branch has pretty massive merge conflicts with cleanup/io-pci and other
branches, in particular due to the large number of conflicting cleanup patches.

It'd be better to focus on just the address decoding pieces in this branch, and
move the cleanups to a separate branch. Given the state of affairs w.r.t.
conflicts for the cleanups, saving those for 3.8 might be a better idea.

I mentioned in one of the other comments to a patch in this series that
I was going to pull this in as staging/* and get linux-next coverage,
but these conflicts are more than what I want to deal with now -- so
I'll hold off pulling these in after all.


-Olof
