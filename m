From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 18 Jun 2013 18:40:50 -0300
Subject: [PATCH v3 11/12] ARM: mvebu: Relocate Armada 370 PCIe device
 tree nodes
In-Reply-To: <201306182320.07351.arnd@arndb.de>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <201306182022.08927.arnd@arndb.de>
 <20130618190223.GA6578@obsidianresearch.com>
 <201306182320.07351.arnd@arndb.de>
Message-ID: <20130618214049.GA15234@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 11:20:07PM +0200, Arnd Bergmann wrote:
> On Tuesday 18 June 2013, Jason Gunthorpe wrote:
> > On Tue, Jun 18, 2013 at 08:22:08PM +0200, Arnd Bergmann wrote:
> > 
> > > > > > Arnd, we've discussed this at length with you while getting the PCIe
> > > > > > driver merged, and we've explained this to you numerous times. Could
> > > > > > you please understand that any of your proposal that suggests writing
> > > > > > down static windows for PCIe devices will not work?
> > > > > 
> > > > > Where did I suggest static windows for PCIe devices?
> > > > 
> > > > Where does your new proposal buys us anything useful compared to the
> > > > existing PCIe DT binding that has been discussed at length with you?
> > > 
> > > I'm pretty sure I explained the idea above originally and was ignored.
> > > Jason Gunthorpe might remember better, but I think he liked it when I
> > > originally proposed doing it this way.
> > 
> > I remember it took a bit to understand your proposal, but I thought it
> > could work, but I admit I forget all the little details now :(
> > 
> > Ah, if I can just rephrase simply - the notion was to move the
> > determination of the aperture to use dynmic allocation and then
> > restructure the ranges around the mbus target, since they no longer
> > need to encode the aperture.
> 
> Right.
> 
> > My concern: dynamically sizing the aperture is hard. There are three
> > apertures that need to be picked, and the PCI core code has no support
> > for dynamic apertures. Getting the aperture from the DT is a
> > functional compromise.
> 
> After some discussion on IRC with Ezequiel, I think it's best to leave
> the aperture listed in DT but say in the binding that the OS may
> override it.
> 

Yes, I'll send a v4 soon, and I'll try to address this correctly,
as you're suggesting.

[...]
> > IMHO, I go back to my original thoughts. There is no real need for any
> > of this to be dynamic, we can use the values in the DT, presumably set
> > by the bootloader and things will work well.
> > 
> > The added complexity and failure modes for dynamic is simply not worth
> > it..
> 
> I don't think it's too hard to be prepared for fully dynamic operation.
> As Grant said in his comment on v2, the real complexity comes from the
> fact that we are mixing dynamic and static configuration here, and
> the PCIe configuration is inherently dynamic.
> 
> The change I'm proposing would just mean the DT representation reflects
> the dynamic nature of the PCIe windows.
> 

Although I'd like the binding to take this into account, for there's no
point in restricting it -a priori- I can't see *any* advantage on doing
fully dynamic window configuration on devices that are fixed in the
first place. It sounds like bloating the whole thing without a strong
need.

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
