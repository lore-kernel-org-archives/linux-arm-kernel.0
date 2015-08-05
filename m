From: broonie@kernel.org (Mark Brown)
Date: Wed, 5 Aug 2015 13:44:12 +0100
Subject: [RFC PATCH 1/5] spi: introduce flag for memory mapped read
In-Reply-To: <CAOMqctQXwcHyiWBwtugSDSE_k65qrNfrwnhjQMDJkLoJMmGzUw@mail.gmail.com>
References: <1438072876-16338-1-git-send-email-vigneshr@ti.com>
 <1438072876-16338-2-git-send-email-vigneshr@ti.com>
 <20150731181745.GM20873@sirena.org.uk> <55BEF4AF.5090704@ti.com>
 <20150804155148.GR20873@sirena.org.uk> <55C0FD98.1090107@ti.com>
 <20150805115013.GJ20873@sirena.org.uk>
 <CAOMqctQXwcHyiWBwtugSDSE_k65qrNfrwnhjQMDJkLoJMmGzUw@mail.gmail.com>
Message-ID: <20150805124412.GN20873@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 05, 2015 at 02:40:01PM +0200, Michal Suchanek wrote:
> On 5 August 2015 at 13:50, Mark Brown <broonie@kernel.org> wrote:

> > As far as I can tell you want to set a per spi_message flag saying that
> > the message is a flash read command?  If that's what this is trying to
> > do then why do you need to set the flag at all?  If the message is in a
> > clearly defined format and it's more efficient to use this mmap mode
> > then surely the driver can just recognise that the format is approprate
> > and switch into mmap mode without being explicitly told - I'm not clear
> > what the flag adds here.

> ehm, the read command is just one byte.

> I don't think sending 03 or other random byte as the first byte of a
> SPI transfer can be used as reliable detection that we are talking to
> a SPI flash memory.

Why care - if something is physically in the same format as a flash read
command how would a device be able to tell that it wasn't actually a
flash read command?  The signals sent on the bus are going to be
identical anyway.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150805/25ee6ec8/attachment.sig>
