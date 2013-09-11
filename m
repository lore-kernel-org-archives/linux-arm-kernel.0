From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Sep 2013 16:07:05 +0100
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <1378908315.2627.392.camel@shinybook.infradead.org>
References: <20980858CB6D3A4BAE95CA194937D5E73EA0C7F4@DBDE04.ent.ti.com>
 <522817D7.1010206@freescale.com> <522D3B79.3060707@freescale.com>
 <20130909151450.GI29403@sirena.org.uk>
 <522EC33B.9000009@freescale.com>
 <20130910180704.GB29403@sirena.org.uk>
 <522FD78A.6080900@freescale.com>
 <20130911104126.GN29403@sirena.org.uk>
 <52304BFF.4060007@freescale.com>
 <1378908315.2627.392.camel@shinybook.infradead.org>
Message-ID: <20130911150705.GT29403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 11, 2013 at 03:05:15PM +0100, David Woodhouse wrote:

> Why can't the flash driver *provide* the required information?

Yeah, that's my question too...

> So far I seem to have got it into my head that we have a SPI controller
> which is connected to more than one device, and we can't send commands
> to one without sending to the other... and that means that we have to
> send a *NOP* to the "unwanted" device. Is that right?

That shouldn't be the case, SPI has a chip select line which is asserted
to talk to a particular chip, while it's not asserted the slaves should
ignore any activity on the bus.  If activity on one slave affects
another something is broken, this is the first time I noticed that being
an issue but I might've missed some of the MTD side of this thread.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130911/51bc0a32/attachment.sig>
