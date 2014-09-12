From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Sep 2014 11:14:42 +0100
Subject: SPI and module auto-loading
In-Reply-To: <5412C1DF.3040707@collabora.co.uk>
References: <54119DB6.8020807@collabora.co.uk>
 <20140911193325.GT4015@sirena.org.uk>
 <5412C1DF.3040707@collabora.co.uk>
Message-ID: <20140912101442.GR7960@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 12, 2014 at 11:50:23AM +0200, Javier Martinez Canillas wrote:
> On 09/11/2014 09:33 PM, Mark Brown wrote:

> > I'm not sure I see that as an interesting use case, it seems better to
> > have drivers usable without DT and it's trivial to do so.

> Yes, it's trivial but seems like an unnecessary duplication for me. AFAICT the
> OF tables are only used to match the devices in spi_match_device() but if both
> the OF and SPI tables must be kept in sync to properly report the module
> aliases to user-space then I wonder if the OF tables shouldn't just be removed
> from the SPI drivers since spi_match_device() will succeed anyways when
> calling spi_match_id().

The vendor identifier is an important part of the OF device ID, vendors
can and do end up with different devices of the same name.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140912/17631b79/attachment.sig>
