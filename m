From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 2 Jan 2016 18:07:46 +0000
Subject: [Question about DMA] Consistent memory?
In-Reply-To: <1451751471.2323.3.camel@HansenPartnership.com>
References: <CAK7LNASd1amcHinXzYy=8mtYbnHUY1G_v=fthpachAVSyjqPZA@mail.gmail.com>
 <20160102103948.GR8644@n2100.arm.linux.org.uk>
 <1451751471.2323.3.camel@HansenPartnership.com>
Message-ID: <20160102180746.GA5779@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 02, 2016 at 08:17:51AM -0800, James Bottomley wrote:
> On Sat, 2016-01-02 at 10:39 +0000, Russell King - ARM Linux wrote:
> > On Thu, Dec 31, 2015 at 04:50:54PM +0900, Masahiro Yamada wrote:
> > > Hi.
> > > 
> > > I am new to the Linux DMA APIs.
> > > 
> > > First, I started by reading Documentation/DMA-API.txt,
> > > but I am confused with the term "consistent memory".
> > 
> > Just read "coherent memory" instead - the documentation confusingly 
> > uses the two terms to refer to the same thing.  I think there was a 
> > patch a while back to replace "consistent" with "coherent" in this 
> > document, though I'm not sure what happened to it.
> 
> It's an standards issue.  The Document was originally based on the PCI
> DMA API.  All the PCI standards documentation refers to "consistent
> memory" instead of "coherent memory".  The original DMA API was
> designed for PA-RISC and its standards documentation refers to
> "coherent memory" hence the confusion.  The two terms are equivalent,
> but there's no real way of removing either without someone reading the
> actual specs and wondering what the other term means.

May it be an idea to add a footnote explaining that the two terms
are interchangable and equivalent then - this is not the first time
that people have asked questions about it, and I suspect that unless
something is done, there will be a continuing stream of questions.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
