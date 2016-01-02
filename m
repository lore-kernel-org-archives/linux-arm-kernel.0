From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Sat, 02 Jan 2016 08:17:51 -0800
Subject: [Question about DMA] Consistent memory?
In-Reply-To: <20160102103948.GR8644@n2100.arm.linux.org.uk>
References: <CAK7LNASd1amcHinXzYy=8mtYbnHUY1G_v=fthpachAVSyjqPZA@mail.gmail.com>
 <20160102103948.GR8644@n2100.arm.linux.org.uk>
Message-ID: <1451751471.2323.3.camel@HansenPartnership.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2016-01-02 at 10:39 +0000, Russell King - ARM Linux wrote:
> On Thu, Dec 31, 2015 at 04:50:54PM +0900, Masahiro Yamada wrote:
> > Hi.
> > 
> > I am new to the Linux DMA APIs.
> > 
> > First, I started by reading Documentation/DMA-API.txt,
> > but I am confused with the term "consistent memory".
> 
> Just read "coherent memory" instead - the documentation confusingly 
> uses the two terms to refer to the same thing.  I think there was a 
> patch a while back to replace "consistent" with "coherent" in this 
> document, though I'm not sure what happened to it.

It's an standards issue.  The Document was originally based on the PCI
DMA API.  All the PCI standards documentation refers to "consistent
memory" instead of "coherent memory".  The original DMA API was
designed for PA-RISC and its standards documentation refers to
"coherent memory" hence the confusion.  The two terms are equivalent,
but there's no real way of removing either without someone reading the
actual specs and wondering what the other term means.

James
