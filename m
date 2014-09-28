From: broonie@kernel.org (Mark Brown)
Date: Sun, 28 Sep 2014 12:19:56 +0100
Subject: [PATCH 1/3] spi:fsl-dspi:add dspi tcfq mode transfer support
In-Reply-To: <1411640665-20671-1-git-send-email-b44548@freescale.com>
References: <1411640665-20671-1-git-send-email-b44548@freescale.com>
Message-ID: <20140928111956.GW27755@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 06:24:23PM +0800, Chao Fu wrote:

> Remove bitbang:
> Add tcf funtions, DSPI module need get cs change information in a spi transfer.
> According cs change, DSPI will give last data the right flag. Bitbang provide
> cs change behind the last data in a transfer. So DSPI can not deal the last data in
> every transfer properly, so remove the bitbang in the driver.
>
> Merge duplicate code:
> 	dspi_data_from_popr
> 	dspi_data_to_pushr
> 
> Remove clk reference in regmap I/O:
> Set the clk parament is NULL in devm_regmap_init_mmio_clk, it will avoid clk handle
> in every register read/write, and advance tranferring efficiency.

Like Shawn says this is three separate changes so should be three
separate patchess.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140928/cbf23951/attachment.sig>
