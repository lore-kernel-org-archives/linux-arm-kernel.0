From: contact@paulk.fr (Paul Kocialkowski)
Date: Wed, 06 May 2015 16:26:13 +0200
Subject: [PATCH v4 1/2] Documentation: devicetree: root node
 serial-number property documentation
In-Reply-To: <CAL_JsqKbSgZ4gXVc=FG_RKic-JM4_Mhzdh3Lh26NCa6zrc74dA@mail.gmail.com>
References: <1430206196-3483-1-git-send-email-contact@paulk.fr>
 <CAL_JsqKbSgZ4gXVc=FG_RKic-JM4_Mhzdh3Lh26NCa6zrc74dA@mail.gmail.com>
Message-ID: <1430922373.2577.24.camel@collins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mercredi 06 mai 2015 ? 08:26 -0500, Rob Herring a ?crit :
> On Tue, Apr 28, 2015 at 2:29 AM, Paul Kocialkowski <contact@paulk.fr> wrote:
> > Open firmware is already using the serial-number property for passing the
> > device's serial number from the bootloader to the kernel. In addition, lshw
> > already has support for scanning this property.
> >
> > The serial number is a string that somewhat represents the device's serial
> > number. It might come from some form of storage (e.g. an eeprom) and be
> > programmed at factory-time by the manufacturer or come from identification
> > bits available in e.g. the SoC (note that the soc_id property in the SoC bus
> > should hold a full account of those bits).
> >
> > The serial number is taken as-is from the bootloader, so it is up to the
> > bootloader to define where the serial number comes from and what length it
> > should be. Some use cases for the serial number require it to have a maximum
> > length (e.g. for USB serial number) and some other cases imply more restrictions
> > on what the serial number should look like (e.g. in Android, the ro.serialno
> > property is usually a 16-bytes (plus one null byte) representation of a 64 bit
> > number).
> >
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
> What Russell was referring to for submitting is his patch tracker:
> 
> http://www.arm.linux.org.uk/developer/patches/

Thanks for the hint, that's done now.

> > ---
> >  Documentation/devicetree/booting-without-of.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/booting-without-of.txt b/Documentation/devicetree/booting-without-of.txt
> > index 7768518..95fc385 100644
> > --- a/Documentation/devicetree/booting-without-of.txt
> > +++ b/Documentation/devicetree/booting-without-of.txt
> > @@ -828,6 +828,10 @@ address which can extend beyond that limit.
> >    name may clash with standard defined ones, you prefix them with your
> >    vendor name and a comma.
> >
> > +  Additional properties for the root node:
> > +
> > +    - serial-number : a string representing the device's serial number
> > +
> >    b) The /cpus node
> >
> >    This node is the parent of all individual CPU nodes. It doesn't
> > --
> > 1.9.1
> >

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150506/fc3e1a07/attachment.sig>
