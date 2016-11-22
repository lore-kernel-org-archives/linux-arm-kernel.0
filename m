From: andrew@aj.id.au (Andrew Jeffery)
Date: Tue, 22 Nov 2016 13:55:45 +1030
Subject: [PATCH v2 3/6] mfd: dt: Add bindings for the Aspeed LPC Host
 Controller (LPCHC)
In-Reply-To: <20161118184535.GE19884@dell.home>
References: <1478097481-14895-1-git-send-email-andrew@aj.id.au>
 <1478097481-14895-4-git-send-email-andrew@aj.id.au>
 <20161118184437.GD19884@dell.home> <20161118184535.GE19884@dell.home>
Message-ID: <1479785145.2503.20.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-11-18 at 18:45 +0000, Lee Jones wrote:
> [Sending Arnd this time!]
> 
> > Arnd,
> > 
> > Do you have a preference?
> > 
> > > The Aspeed LPC Host Controller is presented as a syscon device to
> > > arbitrate access by LPC and pinmux drivers. LPC pinmux configuration on
> > > fifth generation SoCs depends on bits in both the System Control Unit
> > > and the LPC Host Controller.
> > > 
> > > > > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > > ---
> > > ?Documentation/devicetree/bindings/mfd/aspeed-lpchc.txt | 17 +++++++++++++++++
> > 
> > Create a new directory in bindings/mfd called 'syscon'.
> > 
> > Or perhaps 'bindings/syscon'.
> > 

Sounds good to me. I'll wait for Arnd's feedback.

Note that this patch conflicts with some of the ideas I outlined in

https://www.spinics.net/lists/arm-kernel/msg543233.html

I sent it hoping to get some feedback on the approach to take for these
LPC-related bits. Did you have any suggestions? The problems with
hardware complexity are amplified by the fact that the datasheet is
only available under NDA, but I will do what I can to clarify.

> > > ?1 file changed, 17 insertions(+)
> > > ?create mode 100644 Documentation/devicetree/bindings/mfd/aspeed-lpchc.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpchc.txt b/Documentation/devicetree/bindings/mfd/aspeed-lpchc.txt
> > > new file mode 100644
> > > index 000000000000..792651488c3d
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mfd/aspeed-lpchc.txt
> > > @@ -0,0 +1,17 @@
> > > +* Device tree bindings for the Aspeed LPC Host Controller (LPCHC)
> > > +
> > > +The LPCHC registers configure LPC behaviour between the BMC and the host
> > > +system. The LPCHC also participates in pinmux requests on g5 SoCs and is
> > > +therefore considered a syscon device.
> > > +
> > > +Required properties:
> > > > > > +- compatible:		"aspeed,ast2500-lpchc", "syscon"
> > > > > > +- reg:			contains offset/length value of the LPCHC memory
> > > +			region.
> > 
> > Why not just use a single tab, then you don't have to linewrap?

I'll clean that up.

Cheers,

Andrew

> > 
> > > +Example:
> > > +
> > > > > > +lpchc: lpchc at 1e7890a0 {
> > > > > > +	compatible = "aspeed,ast2500-lpchc", "syscon";
> > > > > > +	reg = <0x1e7890a0 0xc4>;
> > > +};
> 
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161122/b6462917/attachment.sig>
