From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 13 Sep 2014 10:18:04 +0200
Subject: [PATCH v3 09/12] ARM: sunxi: dt: Add sample and output mmc clocks
In-Reply-To: <CAGb2v676B=pbKDnAfb3yUdL1ORgbacNTo=5EsTauNo+H993Agw@mail.gmail.com>
References: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
 <1410466706-27386-10-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v676B=pbKDnAfb3yUdL1ORgbacNTo=5EsTauNo+H993Agw@mail.gmail.com>
Message-ID: <20140913081804.GY31276@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 12, 2014 at 06:23:02PM +0800, Chen-Yu Tsai wrote:
> >                 mmc0: mmc at 01c0f000 {
> >                         compatible = "allwinner,sun4i-a10-mmc";
> >                         reg = <0x01c0f000 0x1000>;
> > -                       clocks = <&ahb_gates 8>, <&mmc0_clk>;
> > -                       clock-names = "ahb", "mmc";
> > +                       clocks = <&ahb_gates 8>,
> > +                                <&mmc0_clk>,
> > +                                <&mmc0_sample_clk>,
> > +                                <&mmc0_output_clk>;
> > +                       clock-names = "ahb",
> > +                                     "mmc",
> > +                                     "sample",
> > +                                     "output";
> 
> Just a stylish nitpick. All the other resources in these files
> are listed inline if possible, not one phandle/value per line.

Look at the PIO interrupts, every USB PHY resources, etc. ;)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140913/3cf98b29/attachment.sig>
