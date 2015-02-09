From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 9 Feb 2015 17:20:19 +0100
Subject: [PATCH 03/30] ARM: sun5i: a10s: Move to the common sun5i DTSI
In-Reply-To: <CAGb2v66dwFr2KkGhbc3hmitXAyAmD2dbDCGvXgye3wJCMiE45w@mail.gmail.com>
References: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
 <1422798614-3581-4-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v66dwFr2KkGhbc3hmitXAyAmD2dbDCGvXgye3wJCMiE45w@mail.gmail.com>
Message-ID: <20150209162019.GZ2079@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 02, 2015 at 11:25:45PM +0100, Chen-Yu Tsai wrote:
> Hi,
> 
> On Sun, Feb 1, 2015 at 2:49 PM, Maxime Ripard
> > diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
> > index 09a7df5107ee..e42cbb03620f 100644
> > --- a/arch/arm/boot/dts/sun5i.dtsi
> > +++ b/arch/arm/boot/dts/sun5i.dtsi
> > @@ -349,6 +349,21 @@
> >                         status = "disabled";
> >                 };
> >
> > +               mmc1: mmc at 01c10000 {
> > +                       compatible = "allwinner,sun5i-a13-mmc";
> > +                       reg = <0x01c10000 0x1000>;
> > +                       clocks = <&ahb_gates 9>,
> > +                                <&mmc1_clk 0>,
> > +                                <&mmc1_clk 1>,
> > +                                <&mmc1_clk 2>;
> > +                       clock-names = "ahb",
> > +                                     "mmc",
> > +                                     "output",
> > +                                     "sample";
> > +                       interrupts = <33>;
> > +                       status = "disabled";
> > +               };
> > +
> 
> If it's common hardware then put this and the pinmux in
> sun5i.dtsi in the first patch?

You're right. I'll change that.

Thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150209/226886ec/attachment-0001.sig>
