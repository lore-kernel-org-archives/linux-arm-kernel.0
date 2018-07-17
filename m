From: robh@kernel.org (Rob Herring)
Date: Tue, 17 Jul 2018 08:16:23 -0600
Subject: [PATCH 1/4] dt-bindings: phy: add DT bindings for UniPhier USB3
 PHY driver
In-Reply-To: <20180717195531.8587.4A936039@socionext.com>
References: <1530261541-23104-2-git-send-email-hayashi.kunihiko@socionext.com>
 <20180716205049.GA3663@rob-hp-laptop>
 <20180717195531.8587.4A936039@socionext.com>
Message-ID: <CAL_JsqKjC3J16uk2GTQyTquMbvO5Aw6kr4BfdNLAfZHD3MuBgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2018 at 4:55 AM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> Hi Rob,
> Thank you for your comments.
>
> On Mon, 16 Jul 2018 14:50:49 -0600 <robh@kernel.org> wrote:
>
> > On Fri, Jun 29, 2018 at 05:38:58PM +0900, Kunihiko Hayashi wrote:
> > > Add DT bindings for PHY interface built into USB3 controller
> > > implemented in UniPhier SoCs.
> > >
> > > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > > ---
> > >  .../devicetree/bindings/phy/uniphier-usb3-phy.txt  | 118 +++++++++++++++++++++

[...]

> > > +Optional properties:
> > > +- phy-supply: A phandle to the regulator for USB VBUS.
> >
> > The phy actually needs Vbus or you just want to control Vbus from the
> > phy driver?
>
> To enable each USB port correspond with phy, we must enable Vbus for each port.
> However, the host driver doesn't have the way to control regulators directly,
> then I think it is reasonable to control Vbus by using phy regulator.

DT should reflect the h/w. If Vbus rail is powering the phy then it
should be in the phy node. If you just happen to want to put Vbus
control in the phy driver, that's an OS problem and doesn't belong in
DT. In that case, Vbus should be described as part of a USB connector
node and any driver can walk the tree or graph and get Vbus regulator.

Rob
