From: andrew@aj.id.au (Andrew Jeffery)
Date: Fri, 04 Nov 2016 14:15:57 +1030
Subject: [PATCH v2 3/6] mfd: dt: Add bindings for the Aspeed LPC Host
 Controller (LPCHC)
In-Reply-To: <CACPK8XezumurK6TStNhmTnHdhoJuZBzkJrS3iOArKz1tf1=nLw@mail.gmail.com>
References: <1478097481-14895-1-git-send-email-andrew@aj.id.au>
 <1478097481-14895-4-git-send-email-andrew@aj.id.au>
 <CACPK8XezumurK6TStNhmTnHdhoJuZBzkJrS3iOArKz1tf1=nLw@mail.gmail.com>
Message-ID: <1478231157.27396.72.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-11-04 at 09:36 +1030, Joel Stanley wrote:
> On Thu, Nov 3, 2016 at 1:07 AM, Andrew Jeffery <andrew@aj.id.au> wrote:
> > 
> > The Aspeed LPC Host Controller is presented as a syscon device to
> > arbitrate access by LPC and pinmux drivers. LPC pinmux configuration on
> > fifth generation SoCs depends on bits in both the System Control Unit
> > and the LPC Host Controller.
> > 
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> > ?Documentation/devicetree/bindings/mfd/aspeed-lpchc.txt | 17 +++++++++++++++++
> > ?1 file changed, 17 insertions(+)
> > ?create mode 100644 Documentation/devicetree/bindings/mfd/aspeed-lpchc.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpchc.txt b/Documentation/devicetree/bindings/mfd/aspeed-lpchc.txt
> > new file mode 100644
> > index 000000000000..792651488c3d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/aspeed-lpchc.txt
> > @@ -0,0 +1,17 @@
> > +* Device tree bindings for the Aspeed LPC Host Controller (LPCHC)
> I had to check the data sheet for that acronym. They call the
> registers LHC. I somewhat prefer that name, but if you're happy with
> it as-is then that's fine.

I had an internal debate about this. I figured LPCHC might give a bit
more context to the acronym. I'm not unhappy with it but I wouldn't
claim I'm happy either. I will change it to LHC since you somewhat
prefer it, and it better aligns with the datasheet.

> 
> I assume this is not an issue on the g4/ast2400?

Correct, we don't have the issue of pinmux needing to reach into the
LPC IO space on the AST2400. I don't think we've had anything else to
drive us to looking at the host controller space there, so I wasn't
going to add it to the bindings yet.

> 
> > 
> > +
> > +The LPCHC registers configure LPC behaviour between the BMC and the host
> > +system. The LPCHC also participates in pinmux requests on g5 SoCs and is
> > +therefore considered a syscon device.
> > +
> > +Required properties:
> > +- compatible:??????????"aspeed,ast2500-lpchc", "syscon"
> > +- reg:?????????????????contains offset/length value of the LPCHC memory
> > +???????????????????????region.
> > +
> > +Example:
> > +
> > +lpchc: lpchc at 1e7890a0 {
> > +???????compatible = "aspeed,ast2500-lpchc", "syscon";
> > +???????reg = <0x1e7890a0 0xc4>;
> Where's the 0xc4 come from? I can see 9 registers, which would mean
> the length should be 0x24?

Yes, it should be 0x24. I can't even claim that 'c' is near '2'. Thanks
for catching that.

Andrew

> 
> Cheers,
> 
> Joel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161104/19c05671/attachment.sig>
