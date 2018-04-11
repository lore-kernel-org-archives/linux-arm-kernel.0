From: contact@paulk.fr (Paul Kocialkowski)
Date: Thu, 12 Apr 2018 01:09:59 +0200
Subject: [linux-sunxi] Re: [PATCH 2/3] ARM: dts: sun7i: Add RGB666 pins
 definition
In-Reply-To: <e7f68882-c333-12ac-c122-20b0d7b65666@micronovasrl.com>
References: <20180410213129.24049-1-contact@paulk.fr>
 <20180410213129.24049-2-contact@paulk.fr>
 <e7f68882-c333-12ac-c122-20b0d7b65666@micronovasrl.com>
Message-ID: <588060914d3b6899f6812daa4969f61bf750c91b.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le jeudi 12 avril 2018 ? 00:22 +0200, Giulio Benetti a ?crit :
> Hi,
> 
> Il 10/04/2018 23:31, Paul Kocialkowski ha scritto:
> > This adds the pins definition for RGB666 LCD panels on the A20. It
> > was
> > imported from the A33 definition, that concernes the same set of
> > pins.
> > 
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> >   arch/arm/boot/dts/sun7i-a20.dtsi | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi
> > b/arch/arm/boot/dts/sun7i-a20.dtsi
> > index e529e4ff2174..f46af8675cfa 100644
> > --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> > +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> > @@ -781,6 +781,14 @@
> >   				function = "ir1";
> >   			};
> >   
> > +			lcd_rgb666_pins: lcd_rgb666 at 0 {
> 
> I point you to this Thread and back:
> https://lists.freedesktop.org/archives/dri-devel/2018-March/170688.htm
> l
> 
> I did the same for rgb888, so good part is discussed.
> 
> IMHO I would:
> - call lcd0_rgb666_pins, since this is for LCD0 interface
> - same as above, call lcd0-rgb666, take care about using "-" instad
> of 
> "_" that can cause DTC warnings.
> - remove @0 since only this set can achieve LCD0 RGB666, and I
>    don't think there will be other combinations.

I even responded to that discussion but overlooked these aspects when
crafting this patch. Thanks for the summary :)

> Kind regards
> 
> -- 
> Giulio Benetti
> CTO
> 
> MICRONOVA SRL
> Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
> Tel. 049/8931563 - Fax 049/8931346
> Cod.Fiscale - P.IVA 02663420285
> Capitale Sociale ? 26.000 i.v.
> Iscritta al Reg. Imprese di Padova N. 02663420285
> Numero R.E.A. 258642
> 
> 
> > +				pins = "PD2", "PD3", "PD4", "PD5",
> > "PD6", "PD7",
> > +				       "PD10", "PD11", "PD12",
> > "PD13", "PD14", "PD15",
> > +				       "PD18", "PD19", "PD20",
> > "PD21", "PD22", "PD23",
> > +				       "PD24", "PD25", "PD26",
> > "PD27";
> > +				function = "lcd0";
> > +			};
> > +
> >   			mmc0_pins_a: mmc0 at 0 {
> >   				pins = "PF0", "PF1", "PF2",
> >   				       "PF3", "PF4", "PF5";
> > 
> 
> 
-- 
Paul Kocialkowski,

developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180412/c215aad2/attachment-0001.sig>
