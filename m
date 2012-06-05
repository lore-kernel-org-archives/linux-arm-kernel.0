From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 5 Jun 2012 17:22:14 +0100
Subject: Supporting non-device tree consumers with device tree regulator
 drivers
In-Reply-To: <4FCE30D6.7060102@codeaurora.org>
References: <4FCE30D6.7060102@codeaurora.org>
Message-ID: <20120605162214.GA14958@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2012 at 09:16:22AM -0700, David Collins wrote:

>  Therefore, we are left with a situation currently where some regulator
> consumer drivers are being probed via device tree and some are being
> probed via board file devices within a single platform.  If the regulator
> driver supporting the consumer drivers is converted to use device tree and
> probed via device tree, then the non-device tree consumer drivers will not
> be able to make use of the regulator devices.

This isn't something anyone else seems to be running into - most of the
world is converting entire boards to device tree in one fell swoop and
sticking with normal style until that works.

> Would it be possible to add a new binding that is handled inside of
> of_get_regulator_init_data() or of_get_regulation_constraints() that
> provides a means to directly specify regulator_init_data.consumer_supplies
> entries?  Is there some other mechanism that could be used instead to
> handle the mapping?

> One potentially binding could be:
> regulator-consumer-supplies = "supply_name1", "device_name1",
> "supply_name2", "device_name2", ...

Well, we certainly shouldn't be putting this in the device tree as that
rather defeats the point...  Some sort of auxdata style thing would be
possible I guess but I'm not sure it's worth bothering.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120605/866883f0/attachment.sig>
