From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Aug 2015 16:51:48 +0100
Subject: [RFC PATCH 1/5] spi: introduce flag for memory mapped read
In-Reply-To: <55BEF4AF.5090704@ti.com>
References: <1438072876-16338-1-git-send-email-vigneshr@ti.com>
 <1438072876-16338-2-git-send-email-vigneshr@ti.com>
 <20150731181745.GM20873@sirena.org.uk> <55BEF4AF.5090704@ti.com>
Message-ID: <20150804155148.GR20873@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 03, 2015 at 10:27:19AM +0530, Vignesh R wrote:

> @use_mmap_mode: Some SPI controller chips are optimized for interacting
> with serial flash memories. These chips have memory mapped interface,
> through which entire serial flash memory slave can be read/written as if
> though they are physical memories (like RAM). Using this interface,
> flash can be accessed using memcpy() function and the spi controller
> hardware will take care of communicating with serial flash over SPI.
> Setting this flag will indicate the SPI controller driver that the
> spi_message is from mtd layer to read from/write to flash. The SPI
> master driver can then appropriately switch the controller to memory
> mapped interface to read from/write to flash, based on this flag (See
> drivers/spi/spi-ti-qspi.c for example).
> NOTE: If the SPI controller chip lacks memory mapped interface, then the
> driver will ignore this flag and use normal SPI protocol to read
> from/write to flash. Communication with non-flash SPI devices is not
> possible using the memory mapped interface.

I still can't tell from the above what this interface is supposed to do.
It sounds like the use of memory mapped mode is supposed to be
transparent to users, it should just affect how the controller interacts
with the hardware, but if that's the case why do we need to expose it to
users at all?  Shouldn't the driver just use memory mapped mode if it's
faster?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150804/381b434f/attachment.sig>
