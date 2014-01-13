From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 13 Jan 2014 09:34:52 +0100
Subject: [PATCH RFC 26/46] drivers/base: provide an infrastructure for
 componentised subsystems
In-Reply-To: <20140111114004.GJ15937@n2100.arm.linux.org.uk>
References: <E1Vypo6-0007FF-Lb@rmk-PC.arm.linux.org.uk>
 <20140103031055.GB28751@kroah.com>
 <20140110145444.GE15937@n2100.arm.linux.org.uk>
 <20140110150702.GA22533@kroah.com>
 <20140110151123.GG15937@n2100.arm.linux.org.uk>
 <20140110153530.GA770@kroah.com> <20140110183021.GZ2400@pengutronix.de>
 <20140110204259.GC10235@kroah.com>
 <20140110232336.GI15937@n2100.arm.linux.org.uk>
 <20140111113119.GC2400@pengutronix.de>
 <20140111114004.GJ15937@n2100.arm.linux.org.uk>
Message-ID: <1389602092.6318.7.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, den 11.01.2014, 11:40 +0000 schrieb Russell King - ARM
Linux:
> On Sat, Jan 11, 2014 at 12:31:19PM +0100, Robert Schwebel wrote:
> > On Fri, Jan 10, 2014 at 11:23:37PM +0000, Russell King - ARM Linux wrote:
> > > We do this in DT by providing a "superdevice" node which specifies
> > > the components, eg:
> > > 
> > > 	imx-drm {
> > > 		compatible = "fsl,drm";
> > > 		crtcs = <&ipu1>;
> > > 		connectors = <&hdmi>;
> > > 	};
> > 
> > Saschas comment from 20140109074030.GN6750 at pengutronix.de isn't
> > addressed yet:
> 
> This is not a comment against _this_ patch.  It was a question for Sean
> Paul.  You can tell this by the contents of the To: and Cc: headers on
> Sascha's email.  If that's not what was intended, then the email headers
> are misleading.
> 
> > Sascha Hauer wrote:
> > > Can we have an example with a different number of
> > > encoders/connectors/crtcs, like:
> > > 
> > > exynos-drm {
> > >         compatible = "exynos,drm";
> > >         crtcs = <&fimd1>;
> > >         encoders = <&dp1>, <&hdmi1>, <&lvds1>;
> > >         connectors = <&ptn3460>, <&hdmi1>;
> > > };
> > > 
> > > Otherwise I get the impression that there is some topology of the
> > > components or at least relationship between the components encoded
> > > into the binding.
> > 
> > If I remember correctly, Sascha+Philipp+Lucas still had issues with the
> > bindings, but I'm not sure if they have been already addressed.
> 
> The bindings are not part of this patch.  This patch doesn't even care
> about DT one bit - that's part of the design goal of it.  It doesn't
> care about platform devices either.

Yes, I think the device tree bindings are in need of discussion, but
this is a separate issue. I'd be happy to hear your opinion on the
"imx-drm dt bindings" patches.

> All it cares about is maintaining lists of struct device pointers,
> asking the master device(s) whether they have all their components, and
> binding/unbinding the components at the appropriate moment.  It's
> completely up to the master device operations to decide how to make
> these decisions, and how those decisions are made, whether it be by
> looking up in DT, or ACPI, or whatever.

I'm very much in favor of this particular patch being merged as soon as
sensible.

regards
Philipp
