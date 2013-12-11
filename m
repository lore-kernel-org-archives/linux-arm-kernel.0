From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 11 Dec 2013 11:53:45 +0000
Subject: [PATCH V2 2/4] mtd: spi-nor: add the basic data structures
In-Reply-To: <201312111102.18554.marex@denx.de>
References: <1386318764-15882-1-git-send-email-b32955@freescale.com>
 <201312101407.59958.marex@denx.de>
 <20131211062428.GA25147@shlinux2.ap.freescale.net>
 <201312111102.18554.marex@denx.de>
Message-ID: <20131211115345.GL16780@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > > The spi_nor{} is cloned from the m25p{}.
> > > > +	struct spi_nor_xfer_cfg	cfg;
> > > > +
> > > > +	/* for write_reg */
> > > > +	u8			cmd_buf[SPI_NOR_MAX_CMD_SIZE];
> > > > +
> > > > +	/* the two fundamental primitives */
> > > > +	int (*read_xfer)(struct spi_nor *nor, struct spi_nor_xfer_cfg *cfg,
> > > > +			 u8 *buf, size_t len);
> > > > +	int (*write_xfer)(struct spi_nor *nor, struct spi_nor_xfer_cfg *cfg,
> > > > +			  u8 *buf, size_t len);
> > > > +
> > > > +	int (*read_reg)(struct spi_nor *nor, u8 opcode, u8 *buf, int len);
> > > > +	int (*write_reg)(struct spi_nor *nor, u8 opcode, u8 *buf, int len,
> > > > +			int write_enable);
> > > 
> > > Does the vybrid really support accelerated SPI NOR register IO or does it
> > 
> > The vybrid does not support the accelerated SPI NOR register IO.
> > these hooks are for Lee's driver.
> 
> Which one please?

It's not in Mainline yet, but the patches are on the list.

If you search for st_spi_fsm, you'll find them.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
