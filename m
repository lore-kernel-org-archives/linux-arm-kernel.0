From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Oct 2016 10:15:41 +0100
Subject: [PATCH v3 11/12] scsi/ncr5380: Use correct types for DMA routines
In-Reply-To: <8390541e30d7b7cd418a7b5095fdb4b5fc7aa0ed.1476051962.git.fthain@telegraphics.com.au>
References: <cover.1476051961.git.fthain@telegraphics.com.au>
 <8390541e30d7b7cd418a7b5095fdb4b5fc7aa0ed.1476051962.git.fthain@telegraphics.com.au>
Message-ID: <20161010091541.GX1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2016 at 12:46:53AM -0400, Finn Thain wrote:
> Apply prototypes to get consistent function signatures for the DMA
> functions implemented in the board-specific drivers. To avoid using
> macros to alter actual parameters, some of those functions are reworked
> slightly.
> 
> This is a step toward the goal of passing the board-specific routines
> to the core driver using an ops struct (as in a platform driver or
> library module).
> 
> This also helps fix some inconsistent types: where the core driver uses
> ints (cmd->SCp.this_residual and hostdata->dma_len) for keeping track of
> transfers, certain board-specific routines used unsigned long.
> 
> While we are fixing these function signatures, pass the hostdata pointer
> to DMA routines instead of a Scsi_Host pointer, for shorter and faster
> code.
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> Tested-by: Ondrej Zary <linux@rainbow-software.org>
> Tested-by: Michael Schmitz <schmitzmic@gmail.com>
> ---
>  drivers/scsi/arm/cumana_1.c | 26 ++++++++++------
>  drivers/scsi/arm/oak.c      | 13 ++++----

For these two,

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
