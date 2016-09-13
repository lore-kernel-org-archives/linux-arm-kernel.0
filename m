From: kraxel@redhat.com (Gerd Hoffmann)
Date: Tue, 13 Sep 2016 08:34:38 +0200
Subject: [PATCH v2 2/6] ARM: dts: bcm283x: Define standard pinctrl
 groups in the gpio node.
In-Reply-To: <103847685.101383.df740dd1-92f3-4978-9442-1f1b3a81e9da.open-xchange@email.1und1.de>
References: <1473668576-22256-1-git-send-email-kraxel@redhat.com>
 <1473668576-22256-3-git-send-email-kraxel@redhat.com>
 <1273800480.83718.15854341-2f8e-4e20-95f4-e76f81e6fd56.open-xchange@email.1und1.de>
 <103847685.101383.df740dd1-92f3-4978-9442-1f1b3a81e9da.open-xchange@email.1und1.de>
Message-ID: <1473748478.11547.19.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Hi,

> > > +			emmc_gpio48: emmc_gpio48 {
> > > +				brcm,pins = <48 49 50 51 52 53>;
> > > +				brcm,function = <BCM2835_FSEL_ALT3>;
> > > +			};
> > 
> > Sorry, i didn't notice this before. The naming of these groups suggest 3 muxes
> > for the same eMMC interface. I thought there is a eMMC interface and a SD host
> > interface with different DMA channels.
> > 
> > > +
> > > ...
> > > +
> > > +			sdhost_gpio48: sdhost_gpio48 {
> > > +				brcm,pins = <48 49 50 51 52 53>;
> > > +				brcm,function = <BCM2835_FSEL_ALT0>;
> > > +			};
> > 
> > I think this incorrect. There is no function ALT0 for these pins, only ALT3.
> 
> please forget my last 2 comments. According to this page [1] eMMC is selected by
> ALT3 and sdhost is selected by ALT0.
> 
> Do you know a reliable source where all muxes for both interface are documented?
> The datasheet isn't very helpful here.

No, I don't know any source better than the datasheet @ github.
Yes, I tried to double-check things with the sheet too.

IIRC Eric mentioned a while back in some mail or patch that he checked
something for the rpi device tree with non-public docs, not fully sure
though whenever it was emmc/sdhost or something else.  But I'm basically
trusting Eric here ...

cheers,
  Gerd

PS: This is exactly why I think it us useful to have all those entries
    in the dt file even if unused:  To serve as documentation.
