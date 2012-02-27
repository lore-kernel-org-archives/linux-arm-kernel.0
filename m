From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 27 Feb 2012 13:29:08 +0000
Subject: [PATCH] ARM: 3ds_debugboard: Let ethernet be functional again
In-Reply-To: <20120227090453.GE26642@pengutronix.de>
References: <1328646473-11828-1-git-send-email-festevam@gmail.com>
 <20120213082741.GN3852@pengutronix.de>
 <20120213144820.GA3494@opensource.wolfsonmicro.com>
 <20120214105823.GS3852@pengutronix.de>
 <20120214172902.GB3916@opensource.wolfsonmicro.com>
 <20120216073236.GE3852@pengutronix.de>
 <20120216075825.GA11631@opensource.wolfsonmicro.com>
 <20120227090453.GE26642@pengutronix.de>
Message-ID: <20120227132908.GA3191@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2012 at 10:04:53AM +0100, Sascha Hauer wrote:

> If I drop the microvolts parameter what microvolts should I assume? I
> tried 0 but the regulator core does not like it:

> machine_constraints_voltage: dummy: unsupportable voltage constraints

> (with max: -2147483648 min: 2147483647)

I'd expect zero to work, unless something wants a particular voltage in
which case you really should be filling things in properly.  The fact
that the fixed voltage regulator supports get_voltage() might be
confusing things.

Like I say if people can be bothered filling voltages in I suspect
they're not your target audience for this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120227/2d1c2e04/attachment.sig>
