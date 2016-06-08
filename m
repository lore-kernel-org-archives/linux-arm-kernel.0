From: robh@kernel.org (Rob Herring)
Date: Wed, 8 Jun 2016 14:11:33 -0500
Subject: [PATCH 3/5] ARM: sun8i: dt: Add DT bindings documentation for
 Allwinner sun8i-emac
In-Reply-To: <5755BCAE.6060307@gmail.com>
References: <1464947790-22991-1-git-send-email-clabbe.montjoie@gmail.com>
 <1464947790-22991-4-git-send-email-clabbe.montjoie@gmail.com>
 <20160606141438.GA9510@rob-hp-laptop> <5755BCAE.6060307@gmail.com>
Message-ID: <20160608191133.GA14655@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2016 at 08:10:54PM +0200, Corentin LABBE wrote:
> Le 06/06/2016 16:14, Rob Herring a ?crit :
> > On Fri, Jun 03, 2016 at 11:56:28AM +0200, LABBE Corentin wrote:
> >> This patch adds documentation for Device-Tree bindings for the
> >> Allwinner sun8i-emac driver.
> >>
> >> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> >> ---
> >>  .../bindings/net/allwinner,sun8i-emac.txt          | 64 ++++++++++++++++++++++
> >>  1 file changed, 64 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/net/allwinner,sun8i-emac.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/net/allwinner,sun8i-emac.txt b/Documentation/devicetree/bindings/net/allwinner,sun8i-emac.txt
> >> new file mode 100644
> >> index 0000000..cf71a71
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/net/allwinner,sun8i-emac.txt
> >> @@ -0,0 +1,64 @@
> >> +* Allwinner sun8i EMAC ethernet controller
> >> +
> >> +Required properties:
> >> +- compatible: "allwinner,sun8i-a83t-emac", "allwinner,sun8i-h3-emac",
> >> +		or "allwinner,sun50i-a64-emac"
> >> +- reg: address and length of the register sets for the device.
> >> +- reg-names: should be "emac" and "syscon", matching the register sets
> > 
> > Is syscon shared with other devices? Your example only has 1 reg 
> > address.
> > 
> 
> The example is bad, emac and syscon are two distinct regspaces.
> I will correct the example.

And the syscon registers are not shared with anything else? Typically, 
syscon registers would be a separate node not part of this blocks 
registers. The main thing is make sure you are not creating overlapping 
register addresses.

Rob
