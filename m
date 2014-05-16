From: ben@decadent.org.uk (Ben Hutchings)
Date: Fri, 16 May 2014 23:20:42 +0100
Subject: [Ksummit-discuss] [TECH TOPIC] ARM legacy board DT conversion
 finalization
In-Reply-To: <20140516184205.GL27822@titan.lakedaemon.net>
References: <20140511030009.GO12708@titan.lakedaemon.net>
 <20140511083729.211e9b5f@lwn.net>
 <20140515121546.3A06AC40B0E@trevor.secretlab.ca>
 <CAL_JsqJw11fZBbLVi=xxC559iWdwCMFOJ4XYM-8EjykttoWsOg@mail.gmail.com>
 <20140515194215.GR27822@titan.lakedaemon.net>
 <CAOesGMi0JrTp9kUVDod4duBOCZ+wNRJ0dMmgvBX7jEQRjE5cCA@mail.gmail.com>
 <20140516041022.GY27822@titan.lakedaemon.net>
 <1400265111.2647.54.camel@deadeye.wl.decadent.org.uk>
 <20140516184205.GL27822@titan.lakedaemon.net>
Message-ID: <1400278842.2647.62.camel@deadeye.wl.decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-05-16 at 14:42 -0400, Jason Cooper wrote:
> On Fri, May 16, 2014 at 07:31:51PM +0100, Ben Hutchings wrote:
> > On Fri, 2014-05-16 at 00:10 -0400, Jason Cooper wrote:
> > > Joking aside, I concede your point.  It looks like the last two mvebu
> > > legacy platforms (dove, mv78xx0) might get merged into mach-mvebu during
> > > the next cycle.  After that, we can reach out to the Debian and OpenWRT
> > > guys and see what legacy platforms are in use or rotting.  We can go
> > > from there.
> > 
> > I just removed ixp4xx from Debian as the kernel image wouldn't fit in
> > the NSLU2's kernel partition any more (even after disabling quite a few
> > features that are enabled in most other configurations).  iop32x was
> > removed for the same reason, a while ago.
> 
> Hmmm, I have two NSLU2's, they might make a good platform for the
> tinification/IoT work.  Small flash, small RAM, slow.

Yes, whereas Debian is a general purpose distribution where we don't
attempt to guess which applications will be used on which platforms.

> > Our 'legacy' (which I take to mean pre-v7) configurations are now
> > kirkwood, mv78xx0, orion5x (all about to converge to mvebu) and
> > versatile.
> 
> I'm not familiar with versatile, the others I've seen a few times. ;-)

Versatile is one of ARM's own development boards, but more importantly
it's something QEMU can emulate.

> Does Debian see any user activity with mv78xx0?  I know your build
> system used to have boards with that SoC family, but are there any other
> users?

There is still one build server (ancina.debian.org) using that board,
but I don't know that there are any other users.  The kernel package was
only added to support those build servers.

Ben.

-- 
Ben Hutchings
If you seem to know what you are doing, you'll be given more to do.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140516/f705ca19/attachment.sig>
