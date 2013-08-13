From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 13 Aug 2013 11:59:41 +0200
Subject: [PATCH 4/9] PCI: mvebu: add support for reset on GPIO
In-Reply-To: <20130813103030.1e4156a1@skate>
References: <1376333215-12885-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376333215-12885-5-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130813080956.GE9316@ulmo> <20130813103030.1e4156a1@skate>
Message-ID: <20130813095941.GB30913@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 13, 2013 at 10:30:30AM +0200, Thomas Petazzoni wrote:
> Dear Thierry Reding,
> 
> On Tue, 13 Aug 2013 10:09:56 +0200, Thierry Reding wrote:
> 
> > > +- reset-gpios: optional gpio to PERST#
> > > +- reset-delay-ms: delay in ms to wait after reset de-assertion
> > 
> > I remember some recent discussion about this, and we now have this reset
> > framework, so perhaps it makes more sense to use the reset binding for
> > this? Cc'ing Stephen (as part of the device tree bindings maintainers
> > team) who was involved in that recent reset bindings discussion.
> 
> I also thought about this, but the reset framework seems to be designed
> for "reset controller" IPs, i.e special IPs that are controlling reset
> signals. Looking at Documentation/devicetree/bindings/reset/reset.txt,
> I'm not sure to see how this would apply to GPIO-controlled reset
> signals.

Search for:

[PATCH v10] reset: Add driver for gpio-controlled reset pins

Which aims to be a solution for what you need here.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
