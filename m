From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 2 Jun 2014 09:19:05 +0200
Subject: nommu build failures on ARM in linux-next
In-Reply-To: <20140530080257.GW20155@pengutronix.de>
References: <5387661F.1050000@windriver.com>
 <20140529185534.GK3693@n2100.arm.linux.org.uk>
 <20140529234012.GL3693@n2100.arm.linux.org.uk>
 <20140530080257.GW20155@pengutronix.de>
Message-ID: <20140602071905.GD11207@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, May 30, 2014 at 10:02:57AM +0200, Uwe Kleine-K?nig wrote:
> > Even so, I suspect even with this build problem solved, that's not going
> > to be the end of the story for noMMU breakage... it's certainly something
> > that gets very little testing by anyone.  I suspect it should be removed
> > from the mainline kernel tree rather than being a constant source of these
> > kinds of problems.
> That would mean that support for Cortex-M3 would die, too, which would
> (IMHO) be sad.
Just for your information: The problem in question here doesn't affect
ARM-v7M (aka Cortex-M[34]) because the patch only touches areas
protected by #ifdef CONFIG_CPU_CP15 which is off for these machines.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
