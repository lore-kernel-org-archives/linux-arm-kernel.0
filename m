From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 18 Feb 2014 10:05:18 -0700
Subject: [PATCH 1/2] bus: mvebu-mbus: Fix incorrect size for PCI aperture
 resources
In-Reply-To: <20140214182910.GC31093@google.com>
References: <1392245828-23244-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <20140214182910.GC31093@google.com>
Message-ID: <20140218170518.GA29304@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 14, 2014 at 11:29:10AM -0700, Bjorn Helgaas wrote:
> On Wed, Feb 12, 2014 at 03:57:07PM -0700, Jason Gunthorpe wrote:
> > reg[0] is the DT base, reg[1] is the DT length in bytes,
> > struct resource.end is the inclusive end address, so a -1 is
> > required.
> > 
> > Tested on kirkwood.
> > 
> > Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> 
> Do these two patches need to go together?  I don't maintain
> drivers/bus/mvebu-mbus.c, but if these should be kept together, I'd be
> happy to merge them both, given the appropriate ack from Jason C or Thomas.

I recommend keeping them together, requesting the wrong resource size
range in PCI-E did not fail on my test system, but it has the
potential to fail on systems with a different memory layout.

Thanks,
Jason
