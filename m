From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 11 Mar 2013 09:08:26 +0100
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <20130310160937.37df66b2@skate>
References: <20130307200235.GB20695@obsidianresearch.com>
 <20130307204726.GB1811@avionic-0098.mockup.avionic-design.de>
 <51392B4D.9040404@gmail.com>
 <20130308071443.GA5772@avionic-0098.mockup.avionic-design.de>
 <20130308165228.GB4094@obsidianresearch.com>
 <20130308191227.GA6551@avionic-0098.mockup.avionic-design.de>
 <513A3F4F.2090501@firmworks.com>
 <20130308200245.GC29435@obsidianresearch.com>
 <20130308201339.GA26322@avionic-0098.mockup.avionic-design.de>
 <20130310160937.37df66b2@skate>
Message-ID: <20130311080826.GB6365@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 10, 2013 at 04:09:37PM +0100, Thomas Petazzoni wrote:
> Dear Thierry Reding,
> 
> On Fri, 8 Mar 2013 21:13:40 +0100, Thierry Reding wrote:
> > On Fri, Mar 08, 2013 at 01:02:46PM -0700, Jason Gunthorpe wrote:
> > > On Fri, Mar 08, 2013 at 09:43:11AM -1000, Mitch Bradley wrote:
> > [...]
> > > > 2) The "@0,0" and "@1,0" suffixes do not correspond to the reg values
> > > > <0x0800 0 0 0 0> and <0x1000 0 0 0 0> using any rule that I know.
> > > 
> > > @0,1,0 (bus,device,fn) could be more appropriate, but that is
> > > cosmetic?
> > 
> > The OF PCI specification is pretty strict about this as well. It says in
> > section 2.2.1.3. that only the DD and DD,FF forms can appear in a device
> > path.
> 
> Note that in the case of my driver, the @X,Y represent the port and
> lane of the PCIe interface. Not sure if it is correct, I can change the
> names to whatever is appropriate, those names aren't used anywhere in
> the driver.

I think they need to be changed to be @dev,fn in order to conform to the
OF PCI binding.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130311/40ace6a4/attachment.sig>
