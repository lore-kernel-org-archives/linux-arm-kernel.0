From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Oct 2017 20:10:05 +0200
Subject: [linux-sunxi] [PATCH 08/10] ARM: dts: sun4i: Enable HDMI support
 on some A10 devices
In-Reply-To: <CAGb2v65Z2N24AZp=Y-_YgKuZiT1uSDX5pzMrceU3+TY=+Zdf7g@mail.gmail.com>
References: <20171017121807.2994-1-wens@csie.org>
 <20171017121807.2994-9-wens@csie.org>
 <CAGb2v65Z2N24AZp=Y-_YgKuZiT1uSDX5pzMrceU3+TY=+Zdf7g@mail.gmail.com>
Message-ID: <20171017181005.7x6wwuidzsm7kep3@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 10:38:45PM +0800, Chen-Yu Tsai wrote:
> > diff --git a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
> > index 2d1b4329f54a..e39ec9beef75 100644
> > --- a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
> > +++ b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
> > @@ -58,6 +58,17 @@
> >                 stdout-path = "serial0:115200n8";
> >         };
> >
> > +       hdmi-connector {
> > +               compatible = "hdmi-connector";
> > +               type = "a";
> > +
> > +               port {
> > +                       hdmi_con_in: endpoint {
> > +                               remote-endpoint = <&hdmi_out_con>;
> > +                       };
> > +               };
> > +       };
> > +
> >         leds {
> >                 compatible = "gpio-leds";
> >                 pinctrl-names = "default";
> > @@ -106,6 +117,16 @@
> >         status = "okay";
> >  };
> 
> The LIME's dts change is missing the &de part. :(
> I can fix this when applying.

I've applied all of rest, I'll leave that one up to you, with my
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171017/e5c65c04/attachment.sig>
