From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 12 Sep 2018 09:26:12 +0200
Subject: [PATCH v2 1/4] arm64: dts: rockchip: Split out common nodes for
 Rock960 based boards
In-Reply-To: <20180912031248.GA4880@Mani-XPS-13-9360>
References: <20180911023031.4892-1-manivannan.sadhasivam@linaro.org>
 <9e1868684ed851dfa19300ac2e648cfea7bf3eb9.camel@collabora.com>
 <20180912031248.GA4880@Mani-XPS-13-9360>
Message-ID: <11137562.zz0kzkSHxt@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 12. September 2018, 05:12:48 CEST schrieb Manivannan Sadhasivam:
> Hi Ezequiel,
> 
> On Tue, Sep 11, 2018 at 04:40:29PM -0300, Ezequiel Garcia wrote:
> > On Tue, 2018-09-11 at 08:00 +0530, Manivannan Sadhasivam wrote:
> > > Since the same family members of Rock960 boards (Rock960 and Ficus)
> > > share the same configuration, split out the common nodes into a common
> > > dtsi file for reducing code duplication. The board specific nodes for
> > > Ficus boards are then placed in corresponding board DTS file.
> > 
> > I think it should be possible to move the common USB nodes to the dtsi
> > file, and keep the board-specific (phy-supply property) in the dts files:
> > 
> > &u2phy0_host {
> > 
> >         phy-supply = <&vcc5v0_host>;
> > 
> > };
> > 
> > &u2phy1_host {
> > 
> >         phy-supply = <&vcc5v0_host>;
> > 
> > };
> 
> We can do that but my intention was to entirely partition the nodes
> which are not common. So that it would be less confusing when someone
> looks at it (please correct me if I'm wrong).

The supply is actually named the same on both boards, so you could move
all the usb-nodes to the main dtsi, including the reference to vcc5v0_host
which would then get defined itself in the two board dts.

Then again, seeing that the vcc5v0_host also only differs in the actually
used gpio another option would be to move the whole regulator node
to the dtsi and just define the gpio properties in the board dts files.


Heiko
