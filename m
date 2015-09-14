From: broonie@kernel.org (Mark Brown)
Date: Mon, 14 Sep 2015 19:37:44 +0100
Subject: [PATCH 1/5] spi: introduce mmap read support for spi flash devices
In-Reply-To: <1441355402-6837-2-git-send-email-vigneshr@ti.com>
References: <1441355402-6837-1-git-send-email-vigneshr@ti.com>
 <1441355402-6837-2-git-send-email-vigneshr@ti.com>
Message-ID: <20150914183744.GF12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 04, 2015 at 01:59:58PM +0530, Vignesh R wrote:
> In addition to providing direct access to SPI bus, some spi controller
> hardwares (like ti-qspi) provide special memory mapped port
> to accesses SPI flash devices in order to increase read performance.
> This means the controller can automatically send the SPI signals
> required to read data from the SPI flash device.

Sorry, also meant to say here: as I kind of indicated in response to the
flash patch I'd expect to see the SPI core know something about this and
export an API for this which is integrated with things like the existing
message queue.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150914/48c67bd4/attachment.sig>
