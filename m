From: broonie@kernel.org (Mark Brown)
Date: Thu, 8 Aug 2013 14:08:40 +0100
Subject: [PATCH v2 1/3] hwmon: (lm90) Add power control
In-Reply-To: <52038035.7030803@roeck-us.net>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com>
 <1375944991-29182-2-git-send-email-wni@nvidia.com>
 <20130808110136.GA6427@sirena.org.uk>
 <52038035.7030803@roeck-us.net>
Message-ID: <20130808130840.GC6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 08, 2013 at 04:25:41AM -0700, Guenter Roeck wrote:
> On 08/08/2013 04:01 AM, Mark Brown wrote:

> >That said if you *are* going to do this you should request the
> >regulator using devm_regulator_get_optional(), this is intended to
> >support things that don't need regulators (though that's not the case
> >here).

> The lm90 driver works perfectly fine without regulator.

I'd be most surprised if the device worked without power, if the driver
fails to get and enable a regulator for it then that's not great
(especially if it does so silently).

Note that the regulator API is written to stub itself out if not
enabled, the code should be able to assume that it's there.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130808/9155fabb/attachment.sig>
