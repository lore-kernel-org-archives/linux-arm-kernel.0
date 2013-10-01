From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 1 Oct 2013 12:30:34 -0400
Subject: ..
In-Reply-To: <20130917184146.GD21230@obsidianresearch.com>
References: <20130917184146.GD21230@obsidianresearch.com>
Message-ID: <20131001163034.GZ31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 12:41:46PM -0600, Jason Gunthorpe wrote:
> kirkwood_setup_wins is the last manual caller of mbus in kirkwood, don't
> call it for DT boards and rely on the DT having a mbus node with
> a proper ranges property to setup these windows.
> 
> Move all the mbus ranges properties for all boards into kirkwood.dtsi,
> since they are currently all the same.
> 
> This makes the DT self consistent, since the physical address of the
> NAND and CRYPTO are both referenced internally. The arbitary Linux
> constants KIRKWOOD_NAND_MEM_PHYS_BASE and KIRKWOOD_SRAM_PHYS_BASE
> no longer have to match the DT values.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> ---
>  arch/arm/boot/dts/kirkwood-db-88f6281.dts              | 1 -
>  arch/arm/boot/dts/kirkwood-db-88f6282.dts              | 1 -
>  arch/arm/boot/dts/kirkwood-iconnect.dts                | 1 -
>  arch/arm/boot/dts/kirkwood-mplcec4.dts                 | 1 -
>  arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts | 1 -
>  arch/arm/boot/dts/kirkwood-nsa310.dts                  | 1 -
>  arch/arm/boot/dts/kirkwood-ts219-6282.dts              | 1 -
>  arch/arm/boot/dts/kirkwood.dtsi                        | 5 +++++
>  arch/arm/mach-kirkwood/board-dt.c                      | 1 -
>  9 files changed, 5 insertions(+), 8 deletions(-)

Applied to mvebu/dt with Ezequiel's Ack and Tested-by.  Also fixed
subject line.

thx,

Jason.
