From: tony@atomide.com (Tony Lindgren)
Date: Wed, 27 Jan 2016 10:40:44 -0800
Subject: [PATCH v4 3/3] wlcore/wl12xx: spi: add wifi support to cm-t335
In-Reply-To: <20160113172712.GI12777@atomide.com>
References: <1451482533-8624-1-git-send-email-uri.mashiach@compulab.co.il>
 <1451482533-8624-4-git-send-email-uri.mashiach@compulab.co.il>
 <87io35lq2p.fsf@kamboji.qca.qualcomm.com>
 <5695E802.7050909@compulab.co.il>
 <20160113172712.GI12777@atomide.com>
Message-ID: <20160127184044.GT19432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [160113 09:28]:
> * Igor Grinberg <grinberg@compulab.co.il> [160112 22:01]:
> > Hi Kalle Valo,
> > 
> > On 01/07/16 11:02, Kalle Valo wrote:
> > > Uri Mashiach <uri.mashiach@compulab.co.il> writes:
> > > 
> > >> Device tree modifications:
> > >> - Pinmux for SPI0 and WiFi GPIOs.
> > >> - SPI0 node with wlcore as a child node.
> > >>
> > >> Cc: Tony Lindgren <tony@atomide.com>
> > >> Signed-off-by: Uri Mashiach <uri.mashiach@compulab.co.il>
> > >> ---
> > 
> > Uri, please document the dependencies next time. Thanks!
> > 
> > >> v1 -> v2: Replace interrupts and interrupt-parent with interrupts-extended.
> > >> v2 -> v3: Move the pinctrl-0 = <&wifi_pins> to the wlcore node.
> > >> v3 -> v4: replace interrupts-extended with interrupts and interrupt-parent. (revert v2 modification).
> > >>           According to Rob Herring and Documentation/devicetree/bindings/interrupt-controller/interrupts.txt,
> > >> 	  interrupts-extended should only be used when a device has multiple interrupt parents.
> > >>
> > >>  arch/arm/boot/dts/am335x-cm-t335.dts | 55 ++++++++++++++++++++++++++++++++++++
> > >>  1 file changed, 55 insertions(+)
> > > 
> > > To what tree should this patch go? My wireless-drivers-next tree doesn't
> > > even have this file.
> > 
> > Right. It will hit the mainline during this merge window through Tony's and
> > arm-soc trees.
> > 
> > Do you think it will be sensible if you take 1/3 and 2/3 patches and Tony
> > will take the 3/3 (there is no code dependency between first two and the last one),
> > or we can just wait till arm-soc hits the mainline, so you will have the
> > needed code?
> 
> Yeah I'll pick the dts changes separately after the merge window as
> there is no dependency to the driver changes.

Applying patch 3/3 into omap-for-v4.6/dt thanks.

Tony
