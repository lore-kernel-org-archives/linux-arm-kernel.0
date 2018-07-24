From: contact@paulk.fr (Paul Kocialkowski)
Date: Tue, 24 Jul 2018 19:19:54 +0200
Subject: [linux-sunxi] Re: [PATCH v2 14/16] arm: dts: sun8i: h3: enable
 H3 sid controller
In-Reply-To: <0ab29bf0-b069-338e-f312-e533656fa0b6@gmail.com>
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-15-embed3d@gmail.com>
 <20180129095200.attg7cgvpifpchtn@flea.lan>
 <470ec61e-8b08-5193-ede1-01d02b2c865e@gmail.com>
 <CACNAnaGVSbk7czb+mcGTx1C=YwCWe1qqHQDQe9+PNifwEXovMw@mail.gmail.com>
 <F1D7126A-B6ED-4A83-A941-5F39CED472CE@aosc.io>
 <CACNAnaFMKDmvAUXJngKHWkeGLfjsgn5hhJszNk7Sg4BU98Oafw@mail.gmail.com>
 <0ab29bf0-b069-338e-f312-e533656fa0b6@gmail.com>
Message-ID: <39b1eef01c2ed32f09ef30439c4f4297de009898.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le vendredi 20 avril 2018 ? 11:35 +0200, Philipp Rossak a ?crit :
> Hi Kyle,
> 
> I'm already working on a Version 3 of this patch series. Right now this 
> slowed down since I'm very busy and the ToDo-List is still very long.
> 
> My plan is to send out a version during this release cycle.
> 
> If you need it right now feel free to submit patches!

I just came around this patch while testing SID support for H3, that is
not enabled in the dts at this point despite driver support.

Maxime, would it make sense to merge this patch as-is, without support
for the thermal calibration section, since the two aspects seem rather
independent (and some other SoCs also have a SID node without linkage
for thermal support anyway)?

Cheers,

Paul

> Philipp
> 
> On 19.04.2018 17:19, Kyle Evans wrote:
> > On Thu, Apr 19, 2018 at 10:13 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
> > > 
> > > 
> > > ? 2018?4?19? GMT+08:00 ??11:11:22, Kyle Evans <kevans@freebsd.org> ??:
> > > > On Mon, Jan 29, 2018 at 6:03 AM, Philipp Rossak <embed3d@gmail.com>
> > > > wrote:
> > > > > 
> > > > > 
> > > > > On 29.01.2018 10:52, Maxime Ripard wrote:
> > > > > > 
> > > > > > On Mon, Jan 29, 2018 at 12:29:17AM +0100, Philipp Rossak wrote:
> > > > > > > 
> > > > > > > This patch enables the the sid controller in the H3. It can be used
> > > > > > > for thermal calibration data.
> > > > > > > 
> > > > > > > Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> > > > > > > ---
> > > > > > >    arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
> > > > > > >    1 file changed, 7 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi
> > > > > > > b/arch/arm/boot/dts/sun8i-h3.dtsi
> > > > > > > index 3f83f6a27c74..9bb5cc29fec5 100644
> > > > > > > --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> > > > > > > +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> > > > > > > @@ -72,6 +72,13 @@
> > > > > > >                  };
> > > > > > >          };
> > > > > > >    +     soc {
> > > > > > > +               sid: eeprom at 1c14000 {
> > > > > > > +                       compatible = "allwinner,sun8i-h3-sid";
> > > > > > > +                       reg = <0x01c14000 0x400>;
> > > > > > > +               };
> > > > > > > +       };
> > > > > > > +
> > > > > > 
> > > > > > 
> > > > > > Shouldn't you also use a nvmem-cells property to the THS node?
> > > > > > 
> > > > > > Maxime
> > > > > > 
> > > > > 
> > > > > Oh seems like I forgot that.
> > > > > As related to the wiki [1] this should be 64 bit wide at the address
> > > > 
> > > > 0x34. I
> > > > > will add that in the next version.
> > > > > 
> > > > > 
> > > > > [1]: http://linux-sunxi.org/SID_Register_Guide#eFUSE
> > > > > 
> > > > > Thanks,
> > > > > Philipp
> > > > > 
> > > > 
> > > > Hi,
> > > > 
> > > > Any chance this will see a v3 soon? I'm kind of interested in sid node
> > > > for h3. =)
> > > 
> > > This patch is independent and can be easily sent out
> > > by its own.
> > > 
> > 
> > Right- I had considered doing so, but wanted to make sure I wasn't
> > going to collide with this series if a v3 is imminent.
> > 
> 
> 
-- 
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180724/b9766afb/attachment.sig>
