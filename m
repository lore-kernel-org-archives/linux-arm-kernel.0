From: horms@verge.net.au (Simon Horman)
Date: Thu, 24 Nov 2016 11:17:37 +0100
Subject: [PATCH 0/3] arm64: dts: r8a7796: Add CAN/CAN FD support
In-Reply-To: <HK2PR0601MB132929329C3574A0B4D9A0EAB7B60@HK2PR0601MB1329.apcprd06.prod.outlook.com>
References: <1479903243-1860-1-git-send-email-chris.paterson2@renesas.com>
 <f358442c-8373-328c-1270-709498c133f5@pengutronix.de>
 <20161123142938.GF9057@verge.net.au>
 <HK2PR0601MB132929329C3574A0B4D9A0EAB7B60@HK2PR0601MB1329.apcprd06.prod.outlook.com>
Message-ID: <20161124101733.GA18027@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Thu, Nov 24, 2016 at 10:05:08AM +0000, Chris Paterson wrote:
> Hello Simon,
> 
> From: Simon Horman [mailto:horms at verge.net.au]
> Sent: 23 November 2016 14:30
> > On Wed, Nov 23, 2016 at 02:18:13PM +0100, Marc Kleine-Budde wrote:
> > > On 11/23/2016 01:14 PM, Chris Paterson wrote:
> > > > This patch series adds CAN and CAN FD support to the r8a7796.
> > > >
> > > > Based on renesas-devel-20161122-v4.9-rc6.
> > > >
> > > > Chris Paterson (3):
> > > >   arm64: dts: r8a7796: Add CAN external clock support
> > > >   arm64: dts: r8a7796: Add CAN support
> > > >   arm64: dts: r8a7796: Add CAN FD support
> > > >
> > > >  .../devicetree/bindings/net/can/rcar_can.txt       | 12 +++--
> > > >  .../devicetree/bindings/net/can/rcar_canfd.txt     | 12 +++--
> > > >  arch/arm64/boot/dts/renesas/r8a7796.dtsi           | 61
> > ++++++++++++++++++++++
> > > >  3 files changed, 75 insertions(+), 10 deletions(-)
> > >
> > > For all three:
> > >
> > > Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > >
> > > Who takes this series?
> > 
> > I would like to see these patches split up so that the .../devicetree/bindings/
> > portions can go through you whole the arch/arm64/boot/dts/renesas/
> > portions go thorugh my renesas tree.
> 
> Okay, will do.

Thanks.

> > Regarding the arch/arm64/boot/dts/renesas/ portion, I would like some
> > consideration given to what effect enabling memory above 4Gb (64bit
> > addressing) would have.
> 
> Can you give me some guidance here? I'm not sure what you're referring
> to. As far as I know the DT reg definition here is 64-bit, or are you
> referring to DMA usage? If the later, neither CAN driver uses DMA.

Sorry for not being clearer.

What I would like to know is if there are any problems in the CAN driver
or hardware that would prevent it from functioning with memory that
requires 64bit addressing present.

If the CAN hardware cannot use DMA then DMA doesn't need to be taken into
account. But if it DMA could be enabled in future for CAN, for example
after some driver enhancements, then it would be good to know if 64bit
memory can be supported - if not it would imply DMA cannot be enabled.

As for non-DMA mode, will this function if memory above 4G is present?
If not then in theory such memory couldn't be enabled if the CAN driver
is enabled. This is my main concern.

Does the above help?
