From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 28 Jan 2014 16:23:07 -0800
Subject: [PATCH fix] mtd: nand: kill the the
 NAND_MAX_PAGESIZE/NAND_MAX_OOBSIZE for nand_buffers{}
In-Reply-To: <1389594432-23482-1-git-send-email-b32955@freescale.com>
References: <20140111233937.GF1992@norris-Latitude-E6410>
 <1389594432-23482-1-git-send-email-b32955@freescale.com>
Message-ID: <20140129002307.GD8919@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 02:27:12PM +0800, Huang Shijie wrote:
> The patch converts the arrays to buffer pointers for nand_buffers{}.
> 
> The cafe_nand.c is the only NAND_OWN_BUFFERS user which allocates
> a nand_buffers{} itself.
> 
> This patch disables the DMA for nand_scan_ident, and restore the DMA
> status after we finish the nand_scan_ident. By this way, we can get the
> mtd->writesize and mtd->oobsize, and then allocates the cafe->dmabuf
> with them.
> 
> Since the cafe_nand.c uses the NAND_ECC_HW_SYNDROME ECC mode, we do not
> allocate the buffers for @ecccalc and @ecccode.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
> 
> fix: Setup the DMA address after we have allocated the DMA buffer.

Thanks, looks OK. Pushed to l2-mtd.git/next.

Brian
