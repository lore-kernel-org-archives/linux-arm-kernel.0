From: broonie@kernel.org (Mark Brown)
Date: Mon, 11 Jan 2016 16:47:44 +0000
Subject: [PATCH] regulator: max8973: add THERMAL_OF dependency
In-Reply-To: <7607130.s0M7SSqlJV@wuerfel>
References: <7607130.s0M7SSqlJV@wuerfel>
Message-ID: <20160111164744.GM6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2016 at 09:06:43PM +0100, Arnd Bergmann wrote:

> I've run into the same problem a couple of times now, with every driver
> that calls thermal_zone_of_sensor_register(). I think we need a better
> solution in general, but this fixes the immediate build error for now.

Yes, this doesn't feel very clever especially in this use case where
we're mostly providing data into the thermal framework and not really
relying on it for anything.

> Maybe we should replace the "#ifdef CONFIG_THERMAL_OF" with "#if
> IS_REACHABLE(CONFIG_THERMAL) && IS_ENABLED(CONFIG_THERMAL_OF)"?
> The disadvantage of that is that the thermal management would be
> silently disabled rather than cause a link error, and that may also
> not be desired.

Perhaps we should ensure that at least some glue code is bool rather
than modular?  That's got downsides too, it increases the amount of code
that gets built into the kernel but perhaps that's an acceptable
tradeoff here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160111/74a24dcc/attachment.sig>
