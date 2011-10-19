From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 19 Oct 2011 15:50:00 +0100
Subject: [PATCH v2 3/5] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <20111019144215.GA32007@S2100-06.ap.freescale.net>
References: <1318263578-7407-1-git-send-email-rnayak@ti.com>
	<1318263578-7407-4-git-send-email-rnayak@ti.com>
	<20111018132032.GD30703@S2100-06.ap.freescale.net>
	<4E9EB61C.1040207@ti.com>
	<20111019144215.GA32007@S2100-06.ap.freescale.net>
Message-ID: <20111019144959.GA31850@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2011 at 10:42:16PM +0800, Shawn Guo wrote:

*Please* delete irrelevant quotes from mails.

> On Wed, Oct 19, 2011 at 05:05:56PM +0530, Rajendra Nayak wrote:

> > Yes, it seems like a good idea given that most drivers seem to blindly
> > pass the regulator_init_data onto regulator_register, however there
> > are cases like the twl regulator driver which seems to peek into the
> > constraints passed from the board to make sure it drops anything that
> > the hardware does not support,

> I'm not sure why twl works in that way.  Is it a sign that those
> configuration peeked by twl regulator driver should be encoded in twl
> regulator driver itself instead of being passed from the board?  Or
> why the board does not pass something matching driver/hardware
> capability to save that peek?

It's completely unneeded but harmless, it's there because there were a
large number of discussions going on with the original author and it was
easier to merge the code.
