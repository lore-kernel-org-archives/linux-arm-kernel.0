From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Fri, 29 Jul 2016 10:15:19 +0200
Subject: [PATCH v2 3/5] ARM: sun8i: dt: Add DT bindings documentation for
 Allwinner sun8i-emac
In-Reply-To: <20160728184916.GF6682@lukather>
References: <1469001800-11615-1-git-send-email-clabbe.montjoie@gmail.com>
 <1469001800-11615-4-git-send-email-clabbe.montjoie@gmail.com>
 <20160721075519.GC5993@lukather> <20160728134031.GC7582@Red>
 <20160728184916.GF6682@lukather>
Message-ID: <20160729081519.GA31878@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 28, 2016 at 08:49:16PM +0200, Maxime Ripard wrote:
> On Thu, Jul 28, 2016 at 03:40:31PM +0200, LABBE Corentin wrote:
> > On Thu, Jul 21, 2016 at 09:55:19AM +0200, Maxime Ripard wrote:
> > > Hi,
> > > 
> > > On Wed, Jul 20, 2016 at 10:03:18AM +0200, LABBE Corentin wrote:
> > > > This patch adds documentation for Device-Tree bindings for the
> > > > Allwinner sun8i-emac driver.
> > > > 
> > > > Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> > > > ---
> > > >  .../bindings/net/allwinner,sun8i-emac.txt          | 65 ++++++++++++++++++++++
> > > >  1 file changed, 65 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/net/allwinner,sun8i-emac.txt
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/net/allwinner,sun8i-emac.txt b/Documentation/devicetree/bindings/net/allwinner,sun8i-emac.txt
> > > > new file mode 100644
> > > > index 0000000..4bf4e53
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/net/allwinner,sun8i-emac.txt
> > > > @@ -0,0 +1,65 @@
> > > > +* Allwinner sun8i EMAC ethernet controller
> > > > +
> > > > +Required properties:
> > > > +- compatible: "allwinner,sun8i-a83t-emac", "allwinner,sun8i-h3-emac",
> > > > +		or "allwinner,sun50i-a64-emac"
> > > > +- reg: address and length of the register sets for the device.
> > > > +- reg-names: should be "emac" and "syscon", matching the register sets
> > > 
> > > Blindly mapping a register of some other device on the SoC doesn't
> > > look very reasonable.
> > 
> > As we discuss after this mail on IRC, this register is dedicated to EMAC.
> 
> I don't think we did. It's still right in the middle of some other
> hardware block register space. You actually have a syscon driver to do
> just that, why not use it?
> 

I will try with syscon driver

> > > > +See ethernet.txt in the same directory for generic bindings for ethernet
> > > > +controllers.
> > > > +
> > > > +The device node referenced by "phy" or "phy-handle" should be a child node
> > > > +of this node. See phy.txt for the generic PHY bindings.
> > > > +
> > > > +Optional properties:
> > > > +- phy-supply: phandle to a regulator if the PHY needs one
> > > > +- phy-io-supply: phandle to a regulator if the PHY needs a another one for I/O.
> > > > +		 This is sometimes found with RGMII PHYs, which use a second
> > > > +		 regulator for the lower I/O voltage.
> > > > +- allwinner,tx-delay: The setting of the TX clock delay chain
> > > > +- allwinner,rx-delay: The setting of the RX clock delay chain
> > > 
> > > In which unit? What is the default value?
> > 
> > The unit is unknown to me, but I have added a comment for the
> > default and acceptable range value.
> 
> That's unfortunate. We'll see how the DT maintainers feel about that.
> 

I have searched for txdelay in Documentation, and found a few driver that give the units (us/ps).
But in that case, the value in ps/us must be found in a table indexed by the Xxdelay value.
So the settings seems always a raw number, and for sun8i-emac nothing in user manual could help to find what each value is/related to.

So the good value is either found by "try and test" or "copy the value found in fex file".

Regards

LABBE Corentin
