From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 27 May 2014 09:26:24 +0200
Subject: [GIT PULL] ARM: Keystone reset driver 3.16
In-Reply-To: <20140526212605.GQ27093@quad.lixom.net>
References: <1400880597-7516-1-git-send-email-santosh.shilimkar@ti.com>
 <20140526212605.GQ27093@quad.lixom.net>
Message-ID: <1401175584.4090.22.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Santosh,

Am Montag, den 26.05.2014, 14:26 -0700 schrieb Olof Johansson:
> On Fri, May 23, 2014 at 05:29:57PM -0400, Santosh Shilimkar wrote:
> > Hi Arm-soc folks,
> > 
> > Please pull below keystone reset driver for 3.16 . To avoid merge conflict
> > with earlier keystone-soc pull request[1], I have based the subject pull
> > request on top of it. It merges cleanly with arm-soc 'next/soc2' head. Please
> > apply it against 'next/soc2'. Thanks 
> 
> Hi,
> 
> I notice this driver doesn't have an ack from Philipp Zabel (cc:d here). That
> would be appropriate.

I don't think this driver needs my ack, see below, ...

> (Philipp, should there be a MAINTAINERS entry for you so
> that get_maintainer works as expected here?)

... but that is a good idea to keep me in the loop. I will send a patch.

> I'd also prefer to see the driver and the other changes split up since we tend
> to merge them through different branches. I think it's OK to just split in
> those two for this merge.
> 
> I could do it for you (i.e. merge the first patch into next/drivers and the
> rest into next/soc2 with the driver patch included on the bottom), but that
> still wouldn't cover the ack from Philipp. If he replies to this email and says
> he's ok with it going in I can still do it that way though. Philipp?

This keystone reset driver handles the CPU/SoC reset via soft reset bit.
This does not directly concern the reset controller framework, as it is
not used by this driver.
The reset framework is intended mainly to control reset lines to
peripheral devices that don't stop execution as soon as they are
asserted.
Of course rsctrl_restart() could be modeled as a reset controller using
the framework instead, but I don't think it has to. There already is
other (older) reset code similar to this in various places (such as
arch/arm/mach-pxa/reset.c).

Of course the overlap in terminology (complete system reset vs
peripheral resets) is a bit unfortunate, but I'm not sure what we can do
about this.

regards
Philipp
