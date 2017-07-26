From: megous@megous.com (=?UTF-8?Q?Ond=C5=99ej?= Jirman)
Date: Wed, 26 Jul 2017 14:54:40 +0200
Subject: [linux-sunxi] [PATCH 10/10] ARM: dts: sun8i: Add SY8106A
 regulator to Orange Pi PC
In-Reply-To: <20170726114420.ipirqgbluqmggcjy@flea>
References: <20170723102749.17323-1-icenowy@aosc.io>
 <20170723102749.17323-11-icenowy@aosc.io>
 <CAGb2v66AGjazHT-+hWVLyNBLDw=DJ5yTmNxF-_=BtZFfjnni-A@mail.gmail.com>
 <25C8A89C-8495-4787-934C-8E9667CD70BF@aosc.io>
 <CAGb2v64xXOmC44TKrSDZFAh6i_rgFEccCHj4EG+1fxFJd9fjjw@mail.gmail.com>
 <82507f40a1ddba8517cf09f51d3afa33@aosc.io>
 <1501064628.14577.1.camel@megous.com>
 <20170726114420.ipirqgbluqmggcjy@flea>
Message-ID: <1501073680.20056.3.camel@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime Ripard p??e v St 26. 07. 2017 v 13:44 +0200:
> Hi,
> 
> On Wed, Jul 26, 2017 at 12:23:48PM +0200, Ond?ej Jirman wrote:
> > Hi,
> > 
> > icenowy at aosc.io p??e v St 26. 07. 2017 v 15:36 +0800:
> > > 
> > > > > > 
> > > > > > Otherwse
> > > > > > 
> > > > > > > +               regulator-max-microvolt = <1400000>;
> > > > > > > +               regulator-ramp-delay = <200>;
> > > > > > 
> > > > > > Is this an actual constraint of the SoC? Or is it a characteristic
> > > > > > of the regulator? If it is the latter, it belongs in the driver.
> > > > > > AFAIK the regulator supports varying the ramp delay (slew rate).
> > > 
> > > I don't know...
> > > 
> > > Maybe I should ask Ondrej?
> > 
> > It is probably neither.
> > 
> > It is used to calculate a delay inserted by the kernel between setting
> > a new target voltage over I2C and changing the frequency of the CPU.
> > The actual delay is calculated by the difference between previous and
> > the new voltage.
> > 
> > I don't remember seeing anything in the datasheet of the regulator.
> > This is just some low value that works.
> > 
> > It would probably be dependent on the capacitance on the output of the
> > regulator, actual load (which varies), etc. So it is a board specific
> > value. One could measure it with an oscilloscope if there's a need to
> > optimize this.
> 
> If this is a reasonable default, then this should be in the
> driver. You can't expect anyone to properly calculate a ramp delay and
> have access to both a scope and the CPU power lines.

It translates to 1ms per 0.2V which is highly conservative. The real
times will be in 1-10us range. So I guess this could be a default in
the driver.

regards,
  o.

> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170726/f70a2b27/attachment.sig>
