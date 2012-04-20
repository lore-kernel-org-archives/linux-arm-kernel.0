From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 20 Apr 2012 17:15:18 +0200
Subject: [PATCH 3/7] DRM: add sdrm layer for general embedded system
 support
In-Reply-To: <20120420142558.GB20681@sirena.org.uk>
References: <1334158428-23735-1-git-send-email-s.hauer@pengutronix.de>
 <1334158428-23735-4-git-send-email-s.hauer@pengutronix.de>
 <CAPM=9twdGXNU7kkOnx2GCmofE3KSohdeyuT1dVhvVHTtGA-Ysw@mail.gmail.com>
 <20120420123842.GA25662@avionic-0098.adnet.avionic-design.de>
 <20120420142558.GB20681@sirena.org.uk>
Message-ID: <20120420151518.GR3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2012 at 03:25:58PM +0100, Mark Brown wrote:
> On Fri, Apr 20, 2012 at 02:38:43PM +0200, Thierry Reding wrote:
> > * Dave Airlie wrote:
> > > I get the feeling the drm can just be a virtual platform device of
> > > some sort, then it reads the device tree and binds all the information
> > > on what crtc/encoders are available,
> 
> > That's pretty much what I've come up with in the second round of Tegra DRM
> > patches. Basically display controllers and outputs (RGB, HDMI, TVO, DSI) get
> > separate drivers and register themselves with the DRM driver which then looks
> > at the device tree to see which display controllers to register as CRTCs and
> > parses a list of connector nodes to create encoder/connector pairs that
> > define the physical connectors and their corresponding outputs.
> 
> > I did take a brief look at the SDRM patches as well and they didn't quite
> > seem to fit what was needed for Tegra. But if time allows I'll take a closer
> > look.
> 
> This sounds an awful lot like how ASoC hangs together...

Very much, yes. In ASoC and DRM we both have several physical devices spread
around the SoC which form a logical device. I assume that before ASoC existed
also everyone had a single PCI device which could be used to collect the
information together.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
