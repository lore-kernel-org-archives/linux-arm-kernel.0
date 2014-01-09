From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 9 Jan 2014 08:40:30 +0100
Subject: [PATCH RFC 26/46] drivers/base: provide an infrastructure for
 componentised subsystems
In-Reply-To: <CAOw6vbLBM77Rc554ZrXq_532zwLWyeJ7N_bC22QEaTtbmCUOWg@mail.gmail.com>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
 <E1Vypo6-0007FF-Lb@rmk-PC.arm.linux.org.uk>
 <CAOw6vbJNgdWJvb6t7zJ0Gm6gjXuq8Yd=ySgU+zqg-Kb1j1bBvw@mail.gmail.com>
 <20140108213647.GT27432@n2100.arm.linux.org.uk>
 <CAOw6vbLBM77Rc554ZrXq_532zwLWyeJ7N_bC22QEaTtbmCUOWg@mail.gmail.com>
Message-ID: <20140109074030.GN6750@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 05:39:31PM -0500, Sean Paul wrote:
> On Wed, Jan 8, 2014 at 4:36 PM, Russell King - ARM Linux
> > Which bits do you think would be useful to move into the core?
> > imx_drm_add_components() is rather imx-drm specific, especially for
> > the CRTCs - it carries the knowledge that the OF device to be matched
> > can be found in the _parent_ device, rather than the device registered
> > into the component helpers.
> >
> 
> Yeah, I was thinking of imx_drm_add_components() actually. It probably
> doesn't make sense to enforce the parent relationship in a generic
> manner, but it would be nice to have a helper which added the various
> drm components (crtc/encoder/bridge/connector) with a consistent
> binding.
> 
> We have 3 different exynos boards which would have the following
> superdevices (please forgive my hypothetical syntax/naming):
> 
> Board 1:
> exynos-drm {
>         compatible = "exynos,drm";
>         crtcs = <&fimd1>, <&mixer1>;
>         encoders = <&dp1>, <&hdmi1>;
>         bridges = <&ptn3460 &dp1>;
>         connectors = <&ptn3460>, <&hdmi1>;
> };

Can we have an example with a different number of
encoders/connectors/crtcs, like:

exynos-drm {
        compatible = "exynos,drm";
        crtcs = <&fimd1>;
        encoders = <&dp1>, <&hdmi1>, <&lvds1>;
        connectors = <&ptn3460>, <&hdmi1>;
};

Otherwise I get the impression that there is some topology of the
components or at least relationship between the components encoded
into the binding.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
