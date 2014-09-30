From: ben@decadent.org.uk (Ben Hutchings)
Date: Tue, 30 Sep 2014 02:47:53 +0100
Subject: [PATCH 0/5] m25p80,spi-nor: Fix module aliases for m25p80;
 clean up chip identification
In-Reply-To: <20140928220300.GB3248@norris-Latitude-E6410>
References: <1410714624.3040.38.camel@decadent.org.uk>
 <1410714795.3040.45.camel@decadent.org.uk>
 <20140928220300.GB3248@norris-Latitude-E6410>
Message-ID: <1412041673.9388.75.camel@decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2014-09-28 at 15:03 -0700, Brian Norris wrote:
> On Sun, Sep 14, 2014 at 06:13:15PM +0100, Ben Hutchings wrote:
> > On Sun, 2014-09-14 at 18:10 +0100, Ben Hutchings wrote:
> > > The first patch in the series restores the module aliases to m25p80, but
> > > it does so by duplicating the list of names.  This should be suitable
> > > for stable, but it isn't viable in the longer term.
> > > 
> > > The following patches change the spi-nor interface so that this
> > > duplication is no longer necessary.  This includes removing
> > > spi_nor::read_id, but it could be re-added after this with a different
> > > interface, e.g. returning a flash_info structure (which would need to be
> > > defined in spi_nor.h).
> > 
> > Note that these patch are:
> > - Based on your 'testing' branch
> 
> Which testing branch? These two are the only official
> repos for MTD:
> 
>     git git://git.infradead.org/linux-mtd.git
>     git git://git.infradead.org/l2-mtd.git

You had a testing branch in
git://git.infradead.org/users/norris/linux-mtd.git, and that included
commit af249c3a0ca8 ('mtd: spi-nor: remove duplicated w25q128 entry')
which this patch series depended on.

Ben.

> > - Untested by me, aside from compiling and checking that m25p80 has the
> >   expected module aliases
> 
> Brian

-- 
Ben Hutchings
The two most common things in the universe are hydrogen and stupidity.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 811 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140930/d7e348b5/attachment.sig>
