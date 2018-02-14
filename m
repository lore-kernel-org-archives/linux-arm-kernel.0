From: broonie@kernel.org (Mark Brown)
Date: Wed, 14 Feb 2018 16:04:24 +0000
Subject: [PATCH] spi: bcm2835aux: Avoid 64-bit arithmetic in xfer len calc
In-Reply-To: <20180212193814.17644-1-tpiepho@impinj.com>
References: <1518463905.25398.281.camel@impinj.com>
 <20180212193814.17644-1-tpiepho@impinj.com>
Message-ID: <20180214160424.GF12658@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 12, 2018 at 11:38:14AM -0800, Trent Piepho wrote:
> We want to check for xfers that are over 30 microseconds.  Rather than
> find how many ?s a xfer will take, instead find how many bytes can be
> transferred in 30 ?s.  The latter must be less than 32 bits (since our
> clock speed is limited to 32 bits), while the former involves 64 bit
> quantities and more arithmetic operations.

Please don't bury patches in the middle of existing threads, it makes it
much harder to find them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180214/0cb94b3d/attachment-0001.sig>
