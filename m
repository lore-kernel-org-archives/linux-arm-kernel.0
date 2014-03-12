From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Mar 2014 16:34:27 +0000
Subject: [PATCH 3/3] spi: psdev: add passive serial driver
In-Reply-To: <1394639617-26917-4-git-send-email-m.grzeschik@pengutronix.de>
References: <1394639617-26917-1-git-send-email-m.grzeschik@pengutronix.de>
 <1394639617-26917-4-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <20140312163427.GV28112@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 04:53:37PM +0100, Michael Grzeschik wrote:

> This patch introduces the psdev driver. It is used to communicate to an
> Altera passive serial connected FPGA by writing into an character
> device.
> 
> It simply initates the protocol on open and clocks the data into the
> FPGA by using the underlying SPI bus on write. The used SPI bus can also
> be an bitbang SPI bus. On close it will check for the response of the
> FPGA and tells if the write process was successful.

Having read the above I'm still not entirely sure what this is supposed
to do.  It sounds like it might be something to do with programming
FPGAs but that doesn't seem like something for the SPI subsystem, it
sounds like something for a FPGA handling subsystem.  People keep
talking about that, there's a bunch of other stuff to integrate with
there like loading DTs for the downloeaded bitstream.  I'm not sure what
the status is there.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140312/47cf4251/attachment.sig>
