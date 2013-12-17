From: shijie8@gmail.com (Huang Shijie)
Date: Tue, 17 Dec 2013 21:49:25 +0800
Subject: [PATCH v3 2/7] mtd: spi-nor: add the basic data structures
In-Reply-To: <201312171405.55964.marex@denx.de>
References: <1387184330-14448-1-git-send-email-b32955@freescale.com>
 <1387184330-14448-3-git-send-email-b32955@freescale.com>
 <201312171405.55964.marex@denx.de>
Message-ID: <20131217134923.GA1220@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 02:05:55PM +0100, Marek Vasut wrote:
> On Monday, December 16, 2013 at 09:58:45 AM, Huang Shijie wrote:
> > +struct spi_nor { > > +	struct mtd_info		*mtd;
> > +	struct mutex		lock;
> > +
> > +	/* pointer to a spi device */
> > +	struct device		*dev;
> > +	u32			page_size;
> > +	u8			addr_width;
> > +	u8			erase_opcode;
> > +	u8			read_opcode;
> > +	u8			read_dummy;
> > +	u8			program_opcode;
> > +	enum read_mode		flash_read;
> > +	bool			sst_write_second;
> > +	struct spi_nor_xfer_cfg	cfg;
> 
> You do want to split the function pointers below and the device configuration 
> above into separate structures.

sorry, i prefer to keep them in one data structrue, just like the
nand_chip{} does.

> 
> > +	/* for write_reg */
> > +	u8			cmd_buf[SPI_NOR_MAX_CMD_SIZE];
> > +
> > +	/*
> > +	 * Do some work before or after we run these operations:
> > +	 *   read/write/erese/lock/unlock
> 
> Proper kernel-doc style comments for this structure would be nice.

Do you mean the style used by nand_chip{}?

thanks
Huang Shijie
