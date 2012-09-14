From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 14 Sep 2012 10:23:35 +0100
Subject: [PATCH 06/19] ARM: ux500: Add nodes for the MSP into the HREF
 Device Tree
In-Reply-To: <CACRpkdbs9_hLB9c7WbWeR_6+Le4Svzc9Y5wTNVebOiRDB-o33g@mail.gmail.com>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-7-git-send-email-lee.jones@linaro.org>
 <CACRpkdbs9_hLB9c7WbWeR_6+Le4Svzc9Y5wTNVebOiRDB-o33g@mail.gmail.com>
Message-ID: <20120914092332.GL3374@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 02:53:45AM -0700, Linus Walleij wrote:
> On Fri, Sep 7, 2012 at 1:14 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > This patch enables the two important MSP devices for ST-Ericsson's
> > hardware reference development board.
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  arch/arm/boot/dts/hrefv60plus.dts |    8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/hrefv60plus.dts b/arch/arm/boot/dts/hrefv60plus.dts
> > index 62b2ac1..4f0aee8 100644
> > --- a/arch/arm/boot/dts/hrefv60plus.dts
> > +++ b/arch/arm/boot/dts/hrefv60plus.dts
> > @@ -77,5 +77,13 @@
> >
> >                         status = "okay";
> >                 };
> > +
> > +               msp1: msp at 80124000 {
> > +                       status = "okay";
> > +               };
> > +
> > +               msp3: msp at 80125000 {
> > +                       status = "okay";
> > +               };
> >         };
> >  };
> 
> Does this really "enable" the MSPs as the title claims?

Yes they do.

> Aren's there any kind of bindings needed, not even a
> register base?

All that information is in the "disabled" node contained in .dtsi file.

+               msp0: msp at 80123000 {
+                       compatible = "stericsson,ux500-msp-i2s";
+                       reg = <0x80123000 0x1000>;
+                       interrupts = <0 31 0x4>;
+                       v-ape-supply = <&db8500_vape_reg>;
+                       status = "disabled";

Then this patch "enable"s it (as the title suggests). :)

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
