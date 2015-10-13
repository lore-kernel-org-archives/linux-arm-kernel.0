From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 13 Oct 2015 11:30:27 +0200
Subject: [PATCH 4/6] regulator: core: Propagate voltage changes to supply
 regulators
In-Reply-To: <20151012140737.GB4238@sirena.org.uk>
References: <1443621946-8712-1-git-send-email-s.hauer@pengutronix.de>
 <1443621946-8712-5-git-send-email-s.hauer@pengutronix.de>
 <20151002173256.GZ12635@sirena.org.uk>
 <20151012114259.GU7858@pengutronix.de>
 <20151012140737.GB4238@sirena.org.uk>
Message-ID: <20151013093027.GG7858@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12, 2015 at 03:07:37PM +0100, Mark Brown wrote:
> On Mon, Oct 12, 2015 at 01:42:59PM +0200, Sascha Hauer wrote:
> > On Fri, Oct 02, 2015 at 06:32:56PM +0100, Mark Brown wrote:
> 
> > > One change I think we need here is only doing the propagation if either
> > > the device lacks a set_voltage() operation (in which case it's just a
> > > switch passing through the parent voltage)
> 
> > Does the lack of a set_voltage() operation automatically mean it's a
> > switch passing through the parent voltage? What if the regulator is a
> > fixed regulator and the output can't be controlled because there is only
> > one voltage?
> 
> Sorry, that was a typo for get_voltage().

Ah, that makes it clear.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
