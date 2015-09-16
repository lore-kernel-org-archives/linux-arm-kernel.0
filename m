From: broonie@kernel.org (Mark Brown)
Date: Wed, 16 Sep 2015 16:24:21 +0100
Subject: [PATCH 1/5] spi: introduce mmap read support for spi flash devices
In-Reply-To: <CAD6G_RQOazkS7KHrG75wgMXx1cH_pKjx43Mve6fz1qOJGPpq9w@mail.gmail.com>
References: <1441355402-6837-1-git-send-email-vigneshr@ti.com>
 <1441355402-6837-2-git-send-email-vigneshr@ti.com>
 <CAD6G_RT8Q+Uyp1ZjzHf54Tno1wHm0SmLKEwRAe2gkdp772FD9A@mail.gmail.com>
 <20150914183553.GE12027@sirena.org.uk>
 <CAD6G_RQOazkS7KHrG75wgMXx1cH_pKjx43Mve6fz1qOJGPpq9w@mail.gmail.com>
Message-ID: <20150916152421.GL11268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2015 at 06:16:55PM +0530, Jagan Teki wrote:
> On 15 September 2015 at 00:05, Mark Brown <broonie@kernel.org> wrote:

> > There seem to be a reasonable number of SPI controllers out there which
> > have as an extension the ability to do memory mapped reads but are
> > otherwise perfectly normal SPI controllers and which rely on that for
> > everything except reads.

> This is true, but exposing direct spi-nor arguments or features like
> read_opcode, addr_width or dummy_byte to spi layer isn't fine? because
> for spi layer there is a spi to flash transition mtd m25p80.c is there
> to handle is it?

The m25p80 driver is a generic, SPI level piece of code not a driver for
specific controller hardware.  The controller hardware drivers live in
the SPI subsystem.  In order to support this memory mapped feature we
need the controller drivers to expose an interface for controlling it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150916/d875d560/attachment.sig>
