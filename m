From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Sep 2013 13:35:53 +0100
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA0EAA7@DBDE04.ent.ti.com>
References: <522817D7.1010206@freescale.com> <522D3B79.3060707@freescale.com>
 <20130909151450.GI29403@sirena.org.uk>
 <522EC33B.9000009@freescale.com>
 <20130910180704.GB29403@sirena.org.uk>
 <522FD78A.6080900@freescale.com>
 <20130911104126.GN29403@sirena.org.uk>
 <52304BFF.4060007@freescale.com>
 <20130911113002.GP29403@sirena.org.uk>
 <20980858CB6D3A4BAE95CA194937D5E73EA0EAA7@DBDE04.ent.ti.com>
Message-ID: <20130911123553.GS29403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 11, 2013 at 12:26:10PM +0000, Gupta, Pekon wrote:
> Hi Mark, Shijie,

> > Indeed - what I was wondering was if those opcodes could be requested
> > from the flash driver rather than coded in there.

> As the talk is going in SPI framework direction, therefore requesting again..
> please do not clutter the *generic* SPI framework to pass on opcodes from
> flash-driver (like m25p80). (Q)SPI framework should remain generic and
> independent of any upper layer drivers.

No, this isn't about the SPI framework doing this - this is about
something outside the SPI framework being able tell the SPI controllers
that want to know what the opcodes are so we don't have to do this in
every driver that may be affected.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130911/d6efa5a2/attachment.sig>
