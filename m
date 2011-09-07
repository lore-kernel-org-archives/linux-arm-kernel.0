From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 7 Sep 2011 19:16:41 +0800
Subject: [PATCH 1/6] arm/imx6q: add device tree source
In-Reply-To: <6584331.JVLA1MqVFx@wuerfel>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<1315303120-24203-2-git-send-email-shawn.guo@linaro.org>
	<6584331.JVLA1MqVFx@wuerfel>
Message-ID: <20110907111640.GJ8148@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2011 at 08:31:47PM +0200, Arnd Bergmann wrote:
> On Tuesday 06 September 2011 17:58:35 Shawn Guo wrote:
> > +
> > +       aips-bus at 02000000 { /* AIPS1 */
> > +               compatible = "fsl,aips-bus", "simple-bus";
> > +               #address-cells = <1>;
> > +               #size-cells = <1>;
> > +               reg = <0x02000000 0x100000>;
> > +               ranges;
> > +
> > +               spba-bus at 02000000 {
> > +                       compatible = "fsl,spba-bus", "simple-bus";
> > +                       #address-cells = <1>;
> > +                       #size-cells = <1>;
> > +                       reg = <0x02000000 0x40000>;
> > +                       ranges;
> 
> Wouldn't it be better to have the ranges property translate bus-local addresses
> to global addresses, rather than having an empty ranges property?
> 
All the bus-local addresses are directly mapped into cpu address
space.  Looking at the i.MX Reference Manual memory map chapter,
the base address of each block is given in global address other than
bus address + offset.  Writing a global address in device tree is
relatively easy to match the addresses defined in hardware document.

-- 
Regards,
Shawn
