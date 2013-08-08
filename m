From: broonie@kernel.org (Mark Brown)
Date: Thu, 8 Aug 2013 22:18:25 +0100
Subject: [PATCH v2 1/3] hwmon: (lm90) Add power control
In-Reply-To: <20130808200026.GA18226@roeck-us.net>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com>
 <1375944991-29182-2-git-send-email-wni@nvidia.com>
 <20130808110136.GA6427@sirena.org.uk>
 <52038035.7030803@roeck-us.net>
 <20130808130840.GC6427@sirena.org.uk>
 <5203B78C.7010101@roeck-us.net>
 <20130808171554.GI6427@sirena.org.uk>
 <20130808200026.GA18226@roeck-us.net>
Message-ID: <20130808211825.GN6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 08, 2013 at 01:00:26PM -0700, Guenter Roeck wrote:
> On Thu, Aug 08, 2013 at 06:15:54PM +0100, Mark Brown wrote:

> > Sure, that's the transition issues I mentioned - the regulator API does
> > have stubbing facilities which should cover things and it's very easy to
> > define stub regulators if you need to.  Like I say I expect this to be a
> > lot easier after the next merge window as another way of doing stubs is
> > being added which should make this even easier by avoiding disrupting
> > drivers that do genuinely want to check for absent supplies and handle
> > that better.

> We will need to make sure that all dts files using any of the compatible chips
> are updated accordingly. There are several entries in various dts files for
> adm1032, adt7461, lm90, and nct1008.

Yes, and probably also board files as well.  Or either just accept
bisection trouble for now or wait till the better stubbing is in there -
that will mean that for DT systems the core will just assume the supply
is really there and not fail requests if it's not in the DT.

> > The names requested by a driver are defined with regard to the device
> > and should be the names used by the chip itself as defined in the

> 9 votes for vdd, 11 votes for vcc, one undecided (no datasheet available).
> Guess one is as good as the other ;-).

What I've suggested before is to use the name from the part for which
the driver is named.  Assuming the vendor doesn't randomly change their
datasheet (but that causes problems for hardware engineers so tends to
be avoided).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130808/df7e3102/attachment.sig>
