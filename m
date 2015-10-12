From: broonie@kernel.org (Mark Brown)
Date: Mon, 12 Oct 2015 15:07:37 +0100
Subject: [PATCH 4/6] regulator: core: Propagate voltage changes to supply
 regulators
In-Reply-To: <20151012114259.GU7858@pengutronix.de>
References: <1443621946-8712-1-git-send-email-s.hauer@pengutronix.de>
 <1443621946-8712-5-git-send-email-s.hauer@pengutronix.de>
 <20151002173256.GZ12635@sirena.org.uk>
 <20151012114259.GU7858@pengutronix.de>
Message-ID: <20151012140737.GB4238@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12, 2015 at 01:42:59PM +0200, Sascha Hauer wrote:
> On Fri, Oct 02, 2015 at 06:32:56PM +0100, Mark Brown wrote:

> > One change I think we need here is only doing the propagation if either
> > the device lacks a set_voltage() operation (in which case it's just a
> > switch passing through the parent voltage)

> Does the lack of a set_voltage() operation automatically mean it's a
> switch passing through the parent voltage? What if the regulator is a
> fixed regulator and the output can't be controlled because there is only
> one voltage?

Sorry, that was a typo for get_voltage().

> Currently we bail out int regulator_set_voltage() when we do not have a
> set_voltage() or set_voltage_sel() operation. Instead of propagating the
> voltage change up I would keep the current behaviour and implement voltage
> propagation for switches when we need it. Then we could also introduce a
> REGULATOR_IS_SWITCH flag indicating that this is a switch and not a
> fixed voltage regulator.

We already have people who'd like it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151012/3139e369/attachment.sig>
