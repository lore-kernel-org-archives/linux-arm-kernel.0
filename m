From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 29 Feb 2012 10:00:28 +0000
Subject: [PATCH] ARM: 3ds_debugboard: Let ethernet be functional again
In-Reply-To: <20120229083317.GT3852@pengutronix.de>
References: <20120214172902.GB3916@opensource.wolfsonmicro.com>
 <20120216073236.GE3852@pengutronix.de>
 <20120216075825.GA11631@opensource.wolfsonmicro.com>
 <20120227090453.GE26642@pengutronix.de>
 <20120227132908.GA3191@opensource.wolfsonmicro.com>
 <20120227172020.GC3852@pengutronix.de>
 <20120227235359.GA23230@opensource.wolfsonmicro.com>
 <20120228082715.GK3852@pengutronix.de>
 <20120228105222.GB3683@opensource.wolfsonmicro.com>
 <20120229083317.GT3852@pengutronix.de>
Message-ID: <20120229100027.GA3182@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 29, 2012 at 09:33:17AM +0100, Sascha Hauer wrote:
> On Tue, Feb 28, 2012 at 10:52:22AM +0000, Mark Brown wrote:

> > Can you be more specific about what you think would break here please?

> We started this discussion with a patch of mine in which I wanted to add
> a helper function to register a fixed regulator. You asked me to drop
> the voltage parameter in the helper function as this is mainly used as
> a dummy regulator. I then tried to remove the voltage parameter and it
> turned out that the regulator core needs a voltage because otherwise it
> bails out in machine_constraints_voltage(), more specifically in
> ops->list_voltage(rdev, i) returing 0 for a dummy fixed regulator. You
> then answered that the fixed regulator should be fixed to return an error
> if it hasn't got a voltage configured. At this point the circle is
> complete and we can start the discussion again.

I'm sorry but you're still not explaining what the problem is - what
makes you say that reporting errors and so on instead of zero volts
would cause a problem?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120229/4cde0fad/attachment.sig>
