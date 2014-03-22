From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 22 Mar 2014 14:25:17 +0800
Subject: [PATCH] ARM: dts: ventana: fix eth1 pci dev node
In-Reply-To: <20140318201519.GA8637@obsidianresearch.com>
References: <1394747064-4106-1-git-send-email-tharvey@gateworks.com>
 <20140314132805.GD813@S2101-09.ap.freescale.net>
 <CAJ+vNU2Av-n1-efbFbXNvO4SmoobL_WpQKApFRS1Zjy0egLLzw@mail.gmail.com>
 <20140318201519.GA8637@obsidianresearch.com>
Message-ID: <20140322062432.GB5938@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 18, 2014 at 02:15:19PM -0600, Jason Gunthorpe wrote:
> On Tue, Mar 18, 2014 at 01:02:55PM -0700, Tim Harvey wrote:
> > > Is this whole bridge/switch hierarchy binding documented somewhere
> > > or is this just something that work for you?
> > 
> > I'm not sure where its 'best' documented, but it is the way the
> > kernel works.
> 
> It is documented in the 'PCI Bus Binding to Open Firware'
> publication from IEEE.
> 
> > >> +             pcie at 0,0 {
> > >> +                     /* 01:00.0 PCIe switch */
> > >> +                     #address-cells = <3>;
> > >> +                     #size-cells = <2>;
> > >> +                     device_type = "pci";
> > >> +                     reg = <0x0 0 0 0 0>;
> > >> +
> > >> +                     pcie at 8,0 {
> > >
> > > What's the naming schema for all these pcie nodes?  Generally, we should
> > > have the numbers encoded in the node name coming from the address cells
> > > in 'reg' property.
> 
> The 'reg' property for PCI encodes the device and function number, and
> the suffix in the device path is of the form @DEVICE,FUNCTION (see
> 2.2.1.3 of the spec)
> 
> So device=8, function=0 is @8,0 and reg = 0x4000.

Ok, thanks for the info.  I missed the fact the pointer to the spec has
been there in Documentation/devicetree/bindings/pci/pci.txt.

Shawn
