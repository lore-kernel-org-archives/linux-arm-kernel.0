From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 18 Feb 2014 13:38:01 -0700
Subject: [PATCH 1/2] bus: mvebu-mbus: Fix incorrect size for PCI aperture
 resources
In-Reply-To: <20140217013949.GE7862@titan.lakedaemon.net>
References: <1392245828-23244-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <20140214182910.GC31093@google.com>
 <20140217013949.GE7862@titan.lakedaemon.net>
Message-ID: <20140218203801.GA8786@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 16, 2014 at 08:39:49PM -0500, Jason Cooper wrote:
> On Fri, Feb 14, 2014 at 11:29:10AM -0700, Bjorn Helgaas wrote:
> > On Wed, Feb 12, 2014 at 03:57:07PM -0700, Jason Gunthorpe wrote:
> > > reg[0] is the DT base, reg[1] is the DT length in bytes,
> > > struct resource.end is the inclusive end address, so a -1 is
> > > required.
> > > 
> > > Tested on kirkwood.
> > > 
> > > Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> > 
> > Do these two patches need to go together?  I don't maintain
> > drivers/bus/mvebu-mbus.c, but if these should be kept together, I'd be
> > happy to merge them both, given the appropriate ack from Jason C or Thomas.
> 
> I have one small change for mvebu-mbus queued up, which won't conflict
> here.  Please take both:
> 
> Acked-by: Jason Cooper <jason@lakedaemon.net>

I added the acks and applied both patches to pci/host-mvebu for v3.15,
thanks!

Bjorn
