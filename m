From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Sep 2014 19:47:35 +0200
Subject: [PATCH v2 3/8] Documentation: bindings: net: add the Marvell
 PXA168 Ethernet controller
In-Reply-To: <20140909160136.GA26051@kwain>
References: <1410273848-24663-1-git-send-email-antoine.tenart@free-electrons.com>
 <3827594.chb831jyvc@wuerfel> <20140909160136.GA26051@kwain>
Message-ID: <2897714.QyEFFDa5hL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 September 2014 18:01:36 Antoine Tenart wrote:
> 
> On Tue, Sep 09, 2014 at 05:58:12PM +0200, Arnd Bergmann wrote:
> > On Tuesday 09 September 2014 16:44:03 Antoine Tenart wrote:
> > > +- clocks: pointer to the clock for the device.
> > > +- clock-names: should be "MFUCLK".
> > 
> > Clock names are normally not capitalized. Are you able to change
> > that name when providing a binding or make it an anoymous clock?
> > What does MFU stand for anyway?
> 
> Sure. I could have make it an anonymous clock but the name "MFUCLK" was
> already used by the pxa168 Ethernet driver so I didn't wanted to change
> that.

I believe you can just ask for an anonymous clock anyway and get the
first one even if it has a name, but I didn't check.

In any case, we should not just take a clock name in a DT binding
because it happened to be used by platform code. It's easy fix the
platform code when someone makes a mistake there, but very hard to
fix DT strings once there are users relying on a particular convention.

	Arnd
