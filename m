From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 14 Jan 2015 09:14:54 +0100
Subject: [PATCH 4/4] ARM: mvebu: add Device Tree description of RTC on
 Armada 38x
In-Reply-To: <874mrui8r3.fsf@natisbad.org>
References: <1420817565-28800-1-git-send-email-gregory.clement@free-electrons.com>
 <1420817565-28800-5-git-send-email-gregory.clement@free-electrons.com>
 <874mrui8r3.fsf@natisbad.org>
Message-ID: <20150114081454.GJ4891@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 12:03:12AM +0100, Arnaud Ebalard wrote:
> Hi Gregory,
> 
> Gregory CLEMENT <gregory.clement@free-electrons.com> writes:
> 
> > The Marvell Armada 38x SoCs contains an RTC which differs from the RTC
> > used in the other mvebu SoCs until now. This commit adds the Device
> > Tree description of this interface at the SoC level.
> >
> > Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> > ---
> >  arch/arm/boot/dts/armada-38x.dtsi | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> > index 04fe80d101f8..22909add8889 100644
> > --- a/arch/arm/boot/dts/armada-38x.dtsi
> > +++ b/arch/arm/boot/dts/armada-38x.dtsi
> > @@ -466,6 +466,12 @@
> >  				clocks = <&gateclk 4>;
> >  			};
> >  
> > +			rtc at 184a8 {
> > +				compatible = "marvell,armada-380-rtc";
> > +				reg = <0xa3800 0x20>, <0x184a0 0x0c>;
> > +				interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> > +			};
> > +
> 
> Out of curiosity, why not naming the node rtc at a3800? Main argument:
> least expectation principle when reading the .dtsi and expecting
> increasing addresses. Or did I miss sth else?

Actually, the ePAPR even states that the unit-adress must be the first
address in reg (section 2.2.1.1 of the ePAPR 1.1)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150114/64fb9260/attachment.sig>
