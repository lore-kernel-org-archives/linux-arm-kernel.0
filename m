From: broonie@kernel.org (Mark Brown)
Date: Wed, 23 Mar 2016 12:54:48 +0000
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <56F2852C.5010006@denx.de>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <20160322173546.40d24cc2@free-electrons.com>
 <56F17684.2010307@denx.de> <20160323113316.GH2566@sirena.org.uk>
 <56F2852C.5010006@denx.de>
Message-ID: <20160323125448.GM2566@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2016 at 12:59:40PM +0100, Stefan Roese wrote:
> On 23.03.2016 12:33, Mark Brown wrote:

> > No, there's two separate things here.  The big problem with what you
> > originally sent was that you were defining a window per SPI device but
> > this is a part of the SPI controller so having to change windows per
> > device is just going to make the code more complex.

> I'm sorry, but this sentence is not totally clear to me: Do you mean
> that the "more complex" code in v2 with the MBus window reconfiguration
> is not good? Or do you mean that in the RFC version, the switching
> between the SPI devices was too complex?

I haven't looked at your new code at all.  What I'm saying is that
specifying a per-device MBus window seems like pointless complexity.

> >  There's also the
> > separate issue of where any MBus windows we get come up with.

> Could you also please explain this in more detail? What do you mean
> with that? Do you mean the physical address, that is defined in the
> DT for this MBus window?

I had thought that this was what this subthread was about but you
appeared to be confused.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160323/dba85ad1/attachment.sig>
