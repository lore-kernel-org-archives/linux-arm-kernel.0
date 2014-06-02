From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 02 Jun 2014 13:32:48 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAyLzJdIGNsazogY2xwczcxMXg6IEFkZCBEVCBiaW5kaW5n?=
 =?UTF-8?B?cyBkb2N1bWVudGF0aW9u?=
In-Reply-To: <20140602085651.GA12397@leverpostej>
References: <1401616522-13505-1-git-send-email-shc_work@mail.ru>
 <20140602085651.GA12397@leverpostej>
Message-ID: <1401701568.132789498@f354.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mon, 2 Jun 2014 09:56:51 +0100 ?? Mark Rutland <mark.rutland@arm.com>:
> On Sun, Jun 01, 2014 at 10:55:22AM +0100, Alexander Shiyan wrote:
> > This patch adds DT binding documentation for the Cirrus Logic
> > CLPS711X-based CPUs clock subsystem.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
> >  .../devicetree/bindings/clock/clps711x-clock.txt      | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/clps711x-clock.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/clps711x-clock.txt b/Documentation/devicetree/bindings/clock/clps711x-clock.txt
> > new file mode 100644
> > index 0000000..0fdf3c9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/clps711x-clock.txt
> > @@ -0,0 +1,19 @@
> > +* Clock bindings for the Cirrus Logic CLPS711X CPUs
> > +
> > +Required properties:
> > +- compatible  : Shall contain "cirrus,clps711x-clk".
> > +- reg         : Address of the internal register set.
> > +- cpufreq     : Factory set default frequency in HZ.
> 
> Huh? Why is this called "cpufreq" what is this the frequency of,
> exactly?
> 
> Is this an input or an output?

Modern CLPS711X CPUs support PLL reprogramming, while for older processors,
this procedure is not possible and the CPU clock is set to a fixed value. Thus if the
value of the PLL multiplier is not correct (missing), we use a fixed CPU frequency
of the processor, described in DT, which allows us to use the driver for the new and
old versions of this CPU.

---
