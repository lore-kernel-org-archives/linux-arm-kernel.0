From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 23 Dec 2015 15:11:40 +0000
Subject: [PATCH] ARM: mvebu: Update the mpp63 function in the device tree
 on Armada 370
In-Reply-To: <87k2o5dxbh.fsf@free-electrons.com>
References: <1450881770-21189-1-git-send-email-gregory.clement@free-electrons.com>
 <20151223145707.GJ18249@io.lakedaemon.net>
 <87k2o5dxbh.fsf@free-electrons.com>
Message-ID: <20151223151140.GL18249@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2015 at 04:00:34PM +0100, Gregory CLEMENT wrote:
> Hi Jason,
>  
>  On mer., d?c. 23 2015, Jason Cooper <jason@lakedaemon.net> wrote:
> 
> > Hey Gregory,
> >
> > On Wed, Dec 23, 2015 at 03:42:50PM +0100, Gregory CLEMENT wrote:
> >> Since the commit a526973e0291 ("pinctrl: mvebu: Fix mapping of pin
> >> 63 (gpo -> gpio)"), the mpp63 is no more declared as a GPO but is a
> >> GPIO. Even if in the datasheet this pin is described as GPO, the
> >> experience of the D-Link DNS-327L board shows that it can be used as a
> >> GPIO.
> >
> > I think this is worth a comment in the binding doc to prevent confusion.
> >
> >> This commits generated warnings for the board using this pin as gpo, with
> >> this patch the dts are fixed by using the new function (gpio) instead of
> >> the old one.
> >> 
> >> The binding documentation has also been updated accordingly.
> >> 
> >> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> >> ---
> >>  .../devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt       | 5 ++++-
> >>  arch/arm/boot/dts/armada-370-mirabox.dts                             | 2 +-
> >>  arch/arm/boot/dts/armada-370-netgear-rn104.dts                       | 2 +-
> >>  arch/arm/boot/dts/armada-370-synology-ds213j.dts                     | 2 +-
> >>  4 files changed, 7 insertions(+), 4 deletions(-)
> >> 
> >> diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
> >> index add7c38ec7d8..8662f3aaf312 100644
> >> --- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
> >> +++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
> >> @@ -91,6 +91,9 @@ mpp60         60       gpio, dev(ale1), uart1(rxd), sata0(prsnt), pcie(rstout),
> >>  mpp61         61       gpo, dev(we1), uart1(txd), audio(lrclk)
> >>  mpp62         62       gpio, dev(a2), uart1(cts), tdm(drx), pcie(clkreq0),
> >>                         audio(mclk), uart0(cts)
> >> -mpp63         63       gpo, spi0(sck), tclk
> >> +mpp63         63       gpio, spi0(sck), tclk
> >
> > e.g.
> >
> > mpp63		63	gpio, spi0(sck), tclk (datasheet incorrectly says gpo)
> >
> > or similar.
> >
> > thx,
> >
> > Jason.
> >
> >>  mpp64         64       gpio, spi0(miso), spi0(cs1)
> >>  mpp65         65       gpio, spi0(mosi), spi0(cs2)
> 
> 
> 
> >> +
> >> +Note: According to the datasheet mpp63 is a gpo but there is at least
> >> +one example of a gpio usage on the board D-Link DNS-327L
> This is why I added this note, I thought it was enough.

doh!  Completely missed that.  My mistake.

thx,

Jason.
