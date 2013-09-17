From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 17 Sep 2013 10:32:07 -0300
Subject: [PATCH] arm: Kirkwood - Remove kirkwood_setup_wins and rely on
 the DT binding
In-Reply-To: <20130916224743.GA18349@obsidianresearch.com>
References: <20130916224743.GA18349@obsidianresearch.com>
Message-ID: <20130917133206.GB2488@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

For some reason that I can't recall, the prefered style for commit logs is:

[PATCH] ARM: kirkwood: Remove kirkwood_setup_wins and rely on the DT
binding

(Yes, I know, it's just stupid nit...)

On Mon, Sep 16, 2013 at 04:47:43PM -0600, Jason Gunthorpe wrote:
> kirkwood_setup_wins is the last manual caller of mbus in kirkwood, don't
> call it for DT boards and rely on the board having a mbus node with
> a proper ranges property to setup these windows.
> 
> This makes the DT self consistent, since the physical address of the
> NAND and CRYPTO are both referenced internally. The arbitary Linux
> constants KIRKWOOD_NAND_MEM_PHYS_BASE and KIRKWOOD_SRAM_PHYS_BASE
> no longer have to match the DT values.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> ---
>  arch/arm/boot/dts/kirkwood-db-88f6281.dts              | 5 ++++-
>  arch/arm/boot/dts/kirkwood-db-88f6282.dts              | 5 ++++-
>  arch/arm/boot/dts/kirkwood-iconnect.dts                | 5 ++++-
>  arch/arm/boot/dts/kirkwood-mplcec4.dts                 | 5 ++++-
>  arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts | 5 ++++-
>  arch/arm/boot/dts/kirkwood-nsa310.dts                  | 5 ++++-
>  arch/arm/boot/dts/kirkwood-ts219-6282.dts              | 5 ++++-
>  arch/arm/mach-kirkwood/board-dt.c                      | 1 -
>  8 files changed, 28 insertions(+), 8 deletions(-)
> 

I'm trying to figure out why you're changing just these and not
all of the kirkwood device tree files, but I really can't.

Grep says these contain a nand node:

arch/arm/boot/dts/kirkwood-dockstar.dts
arch/arm/boot/dts/kirkwood-goflexnet.dts
arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
arch/arm/boot/dts/kirkwood-ib62x0.dts
arch/arm/boot/dts/kirkwood-iconnect.dts
arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
arch/arm/boot/dts/kirkwood-km_kirkwood.dts
arch/arm/boot/dts/kirkwood-mplcec4.dts
arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
arch/arm/boot/dts/kirkwood-nsa310.dts
arch/arm/boot/dts/kirkwood-openblocks_a6.dts
arch/arm/boot/dts/kirkwood-topkick.dts

Am I missing something obvious?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
