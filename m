From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 22 Jul 2011 23:10:43 +0200
Subject: [patch 1/3] imx51: add pata device
In-Reply-To: <878vrqnjpa.fsf@lebrac.rtp-net.org>
References: <20110722103710.226100346@rtp-net.org>
	<20110722103832.403681566@rtp-net.org>
	<CAOMZO5Cx2Bkz2HGVV5JT2ietT1c4bvt9583FT8iorwsrAN_ZFA@mail.gmail.com>
	<20110722190957.GF16561@pengutronix.de>
	<878vrqnjpa.fsf@lebrac.rtp-net.org>
Message-ID: <20110722211043.GI16561@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 22, 2011 at 10:28:49PM +0200, Arnaud Patard wrote:
> Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> writes:
> 
> > On Fri, Jul 22, 2011 at 12:14:15PM -0300, Fabio Estevam wrote:
> >> On Fri, Jul 22, 2011 at 7:37 AM, Arnaud Patard
> >> <arnaud.patard@rtp-net.org> wrote:
> >> ...
> >> > +#define imx_mxc_pata_data_entry_single(soc) ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
> >> > + ? ? ? { ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> >> > + ? ? ? ? ? ? ? .iobase = soc ## _ATA_BASE_ADDR, ? ? ? ? ? ? ? ? ? ? ? ?\
> >> > + ? ? ? ? ? ? ? .irq = soc ## _MXC_INT_ATA, ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> >> 
> >> Why not imx_pata_data_entry_single instead?
> >> 
> >>  "imx_mxc" looks redundant.
> > imx is the platform prefix, mxc_pata the device's name. So IMHO the name
> > is right and consistent with the other device registration stuff.
> 
> From looking at devices-imx51.h, I don't see no obvious consistant
> naming scheme :
> 
> extern const struct imx_fec_data imx51_fec_data;
driver name: fec
> ...
> extern const struct imx_imx_i2c_data imx51_imx_i2c_data[];
driver name: imx_i2c
> ...
> extern const struct imx_mxc_nand_data imx51_mxc_nand_data;
driver name: mxc_nand
> ...
> extern const struct imx_spi_imx_data imx51_cspi_data;
driver name: spi_imx

So the driver names are not consistent, ok. But the names used in
devices-imx51.h match these. It's always imx_${drivername}_data.

> So, I can use either imx_pata_data or keep imx_mxc_pata_data or
> imx_imx_pata_data or imx_pata_imx_data. What do you both prefer ?
So if your driver is called "mxc_pata", please use
imx_mxc_pata_data_entry_single.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
