From: andrew@aj.id.au (Andrew Jeffery)
Date: Thu, 08 Dec 2016 22:38:26 +1030
Subject: [PATCH v3 4/6] mfd: dt: Add bindings for the Aspeed LPC Host
 Controller (LHC)
In-Reply-To: <CACPK8XfuZ14Ud3Kginut7f0-_-UjTB-=Pma-9WwNecF93k0Ktg@mail.gmail.com>
References: <20161206025321.1792-1-andrew@aj.id.au>
 <20161206025321.1792-5-andrew@aj.id.au>
 <CACPK8XfuZ14Ud3Kginut7f0-_-UjTB-=Pma-9WwNecF93k0Ktg@mail.gmail.com>
Message-ID: <1481198906.3112.4.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-12-08 at 12:42 +1030, Joel Stanley wrote:
> > On Tue, Dec 6, 2016 at 1:23 PM, Andrew Jeffery <andrew@aj.id.au> wrote:
> > The LPC bus pinmux configuration on fifth generation Aspeed SoCs depends
> > on bits in both the System Control Unit and the LPC Host Controller.
> > 
> > The Aspeed LPC Host Controller is described as a child node of the
> > LPC host-range syscon device for arbitration of access by the host
> > controller and pinmux drivers.
> > 
> > > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> > ?.../devicetree/bindings/mfd/aspeed-lpc.txt?????????| 22 ++++++++++++++++++++++
> > ?1 file changed, 22 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> > index a97131aba446..9de318ef72da 100644
> > --- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> > +++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> > > > @@ -109,3 +109,25 @@ lpc: lpc at 1e789000 {
> > ????????};
> > ?};
> > 
> > +Host Node Children
> > +==================
> > +
> > +LPC Host Controller
> > +-------------------
> > +
> > +The Aspeed LPC Host Controller configures the Low Pin Count (LPC) bus behaviour
> > +between the host and the baseboard management controller. The registers exist
> > +in the "host" portion of the Aspeed LPC controller, which must be the parent of
> > +the LPC host controller node.
> > +
> > +Required properties:
> > +- compatible:??????????"aspeed,ast2500-lhc";
> 
> Can you remind me why this binding doesn't cover the ast2400?

Partly that we haven't yet needed the LHC for the AST2400.

Mostly that I overlooked it.

If there are other problems with series I'll address this issue, but if
not we can add it when we need it down the track.

Andrew

> 
> Cheers,
> 
> Joel
> 
> > +- reg:?????????????????contains offset/length value of the LHC memory
> > +???????????????????????region.
> > +
> > +Example:
> > +
> > > > +lhc: lhc at 20 {
> > +???????compatible = "aspeed,ast2500-lhc";
> > +???????reg = <0x20 0x24 0x48 0x8>;
> > +};
> > --
> > 2.9.3
> > 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161208/08062be4/attachment.sig>
