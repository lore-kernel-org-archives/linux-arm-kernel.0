From: broonie@kernel.org (Mark Brown)
Date: Wed, 19 Jun 2013 20:24:49 +0100
Subject: [RFC PATCH 00/11] ARM: s3c64xx: Let amba-pl08x driver handle DMA
In-Reply-To: <201306192101.34102.arnd@arndb.de>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <20130619174047.GB1403@sirena.org.uk> <3697657.tZFV7pR81Q@flatron>
 <201306192101.34102.arnd@arndb.de>
Message-ID: <20130619192449.GI1403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 09:01:33PM +0200, Arnd Bergmann wrote:
> On Wednesday 19 June 2013, Tomasz Figa wrote:

> > >       if (plchan->mux_use++ == 0 && pd->get_signal) {
> > > -             ret = pd->get_signal(plchan->cd);
> > > +             ret = (pd->get_signal)(plchan->cd);

> > Hmm, that's strange. The former is a completely valid piece of code...

> get_signal is a macro defined in include/linux/signal.h. If that header
> gets included, neither of the two is valid.

Ah, that'll be it.  I'll post a patch to rename...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130619/23ffa763/attachment.sig>
