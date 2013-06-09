From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sun, 9 Jun 2013 11:34:24 -0300
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <1695243.lt6nZouziV@wuerfel>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130607200054.GA9010@obsidianresearch.com>
 <20130608183851.GB2354@localhost> <1695243.lt6nZouziV@wuerfel>
Message-ID: <20130609143422.GA2353@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 09, 2013 at 03:42:24PM +0200, Arnd Bergmann wrote:
> On Saturday 08 June 2013 15:38:52 Ezequiel Garcia wrote:
> > On Fri, Jun 07, 2013 at 02:00:54PM -0600, Jason Gunthorpe wrote:
> 
> > Right. I think we have two options here for laying the DT ranges.
> > 
> > 1) This is the proposal implied in the patchset I sent:
> > 
> > mbus {
> > 	ranges = < we only put the internal-reg translation here>
> > 	devbus-bootcs {
> > 		ranges = <0 {target_id/attribute} {window_physical_base} {size}>
> > 	}
> > }
> 
> As Jason explained, you cannot have the window_physical_base in the child
> device, that just wouldn't work. I don't know if that's a typo or a thinko ;-)
> 

I'm not sure what you mean by "that just wouldn't work". I understand it
may be a crappy DT layout, but it definitely works.

The proposal I've sent in this patchset has been fully tested and works
in A370 and AXP, with NOR, and PCIe devices. 
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
