From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 3 Jan 2013 15:20:04 +0100
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <20130102200932.GA2956@obsidianresearch.com>
References: <50CFD0B3.6030208@wwwdotorg.org>
 <20121218025113.GA27029@obsidianresearch.com>
 <50D0A1EA.9090009@wwwdotorg.org>
 <20121220153231.GA11256@avionic-0098.adnet.avionic-design.de>
 <20121222155040.61829b00@skate>
 <20121228210622.GA4519@avionic-0098.adnet.avionic-design.de>
 <20121228221632.3892e90b@skate> <50DE2FFB.8040804@wwwdotorg.org>
 <20121229093359.GA5877@avionic-0098.adnet.avionic-design.de>
 <20130102200932.GA2956@obsidianresearch.com>
Message-ID: <20130103142003.GA8274@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 02, 2013 at 01:09:32PM -0700, Jason Gunthorpe wrote:
> On Sat, Dec 29, 2012 at 10:33:59AM +0100, Thierry Reding wrote:
> 
> > It isn't actually required to make PCI work, but it enables PCI device
> > matching to DT nodes with the generic code. If we leave out the host
> > bridge, then the matching becomes rather complicated and we'll most
> 
> Can you elaborate on this a bit? What do pci bus location bindings look
> like?

Basically what you do is describe the PCI bus hierarchy using DT nodes,
where the reg properties are used to match device nodes to their PCI
devices. You can see a basic example for the controller here[0] and an
actual board DT here[1].

Contrary to what I said earlier, more recent tests seem to indicate that
the matching does indeed work even without the fake host bridge device.
Perhaps one of the changes or cleanups caused this. I'll do some further
testing to confirm this.

> BTW, does anyone have working links for the various PDFs (ePAR, PCI
> bindings, etc) for open firmware stuff, they all seem broken these
> days..

The ePAPR 1.1 and the PCI bindings are available here[2] and here[3].

[0]: https://gitorious.org/thierryreding/linux/blobs/tegra/next/arch/arm/boot/dts/tegra20.dtsi#line369
[1]: https://gitorious.org/thierryreding/linux/blobs/tegra/next/arch/arm/boot/dts/tegra20-tec.dts#line67
[2]: https://www.power.org/wp-content/uploads/2012/07/Power_ePAPR_APPROVED_v1.1.pdf
[3]: http://www.openfirmware.org/ofwg/bindings/pci/pci2_1.pdf

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130103/612829a7/attachment.sig>
