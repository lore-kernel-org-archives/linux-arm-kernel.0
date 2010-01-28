From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 28 Jan 2010 10:29:22 +0100
Subject: [PATCHv2] ARM: S3C64XX: SPI: Make platform device compilation
	selectable
In-Reply-To: <1b68c6791001280112h5054a260rc5b37d3adc7c5576@mail.gmail.com>
References: <1264666489-24789-1-git-send-email-jassisinghbrar@gmail.com>
	<20100128090239.GD13756@pengutronix.de>
	<1b68c6791001280112h5054a260rc5b37d3adc7c5576@mail.gmail.com>
Message-ID: <20100128092922.GE13756@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2010 at 06:12:30PM +0900, jassi brar wrote:
> 2010/1/28 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > On Thu, Jan 28, 2010 at 05:14:49PM +0900, jassisinghbrar at gmail.com wrote:
> >> From: Jassi Brar <jassi.brar@samsung.com>
> >>
> >> The SPI controller platform devices should be compiled in
> >> independent of the driver support, otherwise we might end
> >> up with dev-spi built as kernel module.
> >> Change this to make every machine select if it has some SPI
> >> device and wants to build device definitions.
> > Is it correct that S3C64XX_DEV_SPI for now is always unselected and so
> > dev-spi.o is never compiled? ?Assuming there are already machines using
> > it the corresponding symbols should select S3C64XX_DEV_SPI, don't they?
> >
> > If that's wrong the last sentence in your commit log is confusing.
> Hello,
> No machine currently uses s3c64xx-spi, so it's ok.
> In future a s3c64xx based machine has to select S3C64XX_DEV_SPI
>  if it has some device attached to the SPI bus.
OK, then maybe change the commit log to:

	The SPI controller platform devices should be compiled in
	independent of the driver support, otherwise we might end up
	with dev-spi built as kernel module.

	So now every machine that has some SPI device should select
	S3C64XX_DEV_SPI.  Currently there is no such machine in mainline
	yet.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
