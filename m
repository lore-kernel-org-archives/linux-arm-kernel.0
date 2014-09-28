From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 28 Sep 2014 16:52:18 +0800
Subject: [PATCH 1/3] spi:fsl-dspi:add dspi tcfq mode transfer support
In-Reply-To: <1411640665-20671-1-git-send-email-b44548@freescale.com>
References: <1411640665-20671-1-git-send-email-b44548@freescale.com>
Message-ID: <20140928085216.GA2383@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 06:24:23PM +0800, Chao Fu wrote:
> From: Chao Fu <B44548@freescale.com>
> 
> TCFQ is interrupt of Transfer Complete Flag in DSPI module.
> EOQ is interrupt of End of Queue Flag in DSPI module.
> For adopting of different platform, either of them is a way of DSPI
> transfer data. This patch add TCF support for DSPI module  in other platform.
> 
> The software will be changed in two transfer methods as followwing:
> 		 EOQ			TCFQ
> transfer data: dspi_eoq_write	  dspi_tcfq_write
> receive data:  dspi_eoq_read	  dspi_tcfq_read
> 
> Using which method will decided by paltform soc dtsi file.
> 
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
> 
> Signed-off-by: Chao Fu      <b44548@freescale.com>

It looks you are doing too many things in a single patch.  You should
probably split into several patches to make the review process a little
easier.

Shawn
