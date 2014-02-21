From: ben@decadent.org.uk (Ben Hutchings)
Date: Fri, 21 Feb 2014 01:47:31 +0000
Subject: [PATCH 21/21] ARM: Kirkwood: Remove DT support
In-Reply-To: <35719313.JyFlzSVKnx@wuerfel>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <2127012.W6WnQnXmRo@wuerfel>
 <1392906070.30563.11.camel@kazak.uk.xensource.com>
 <35719313.JyFlzSVKnx@wuerfel>
Message-ID: <1392947251.15717.28.camel@deadeye.wl.decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-02-20 at 16:19 +0100, Arnd Bergmann wrote:
> On Thursday 20 February 2014 14:21:10 Ian Campbell wrote:
> > On Thu, 2014-02-20 at 14:53 +0100, Arnd Bergmann wrote:
> > > On Thursday 20 February 2014 12:51:04 Ian Campbell wrote:
> > > * ixp4xx is too different from the others and I don't think it's
> > >   possible to turn it over to multiplatform.
> > > * I see a iop32x_defconfig in svn that you didn't mention here,
> > >   but it's basically the same problem as ixp4xx.
> > 
> > This is only in Wheezy and not in trunk (which will become Jessie). AIUI
> > support for these has been dropped for the next version of Debian so
> > Wheezy is the last one and we don't need to worry about upgrade for
> > these.
> 
> Ok, I see.
>
> > TBH I'm not sure that ixp4xx isn't in the same boat, I suppose we'll
> > see.
> 
> For all I know, the only interesting ixp4xx platforms are the consumer
> products listed on http://www.nslu2-linux.org/, the other ones you support
> are development boards that tend to exist only in very small quantities.
> 
> The main limitation would be the amount of installed RAM, which is
> either 32MB or 64MB depending on the machine for these. Running a
> modern Debian with these constraints is probably possible but
> doesn't sound like fun. ;-)

Our most pressing constraint has actually been the size of the kernel
partition in flash, which is only ~1.4 MB on some of the iop32x and
ixp4xx machines (and ~1.5 MB on one of the orion5x machines).  We've
modularised as much as possible and turned off some of the features that
are otherwise standard across all Debian architectures.

But I got fed up with trying to make it fit, and no-one else stepped up
to maintain the reduced configurations, so the last time iop32x went
over the limit I removed it.  As Ian hinted, ixp4xx might follow.

> Also, the upstream kernel port isn't that well maintained, a lot
> the development seems to have happened in OpenWRT and not mainlined,
> including a dozen new machines that were already ported in 2009.
> 
> Then again, Martin Michlmayr has instructions for running Wheezy
> on the 32MB nslu2, and I guess as long as he's interested in the
> hardware, new versions of Debian will keep running on it.
[...]

Martin is not currently active in Debian kernel maintenance.

Ben.

-- 
Ben Hutchings
A free society is one where it is safe to be unpopular. - Adlai Stevenson
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 811 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140221/27dba2db/attachment.sig>
