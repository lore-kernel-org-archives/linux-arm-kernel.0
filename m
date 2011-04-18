From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 18 Apr 2011 11:12:15 +0200
Subject: [RFC 0/4] convert stmp into mxs and delete the obsolete platform
In-Reply-To: <BANLkTikybn1pwiz-SrgdSwV6aRcKHMAENg@mail.gmail.com>
References: <1303093838-23959-1-git-send-email-w.sang@pengutronix.de>
	<BANLkTikybn1pwiz-SrgdSwV6aRcKHMAENg@mail.gmail.com>
Message-ID: <20110418091215.GC31131@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2011 at 08:23:37AM +0200, Vitaly Wool wrote:
> Hi Wolfram,
> 
> On Mon, Apr 18, 2011 at 4:30 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> > I tried a smaller scaled cleanup before, but now that there are talks about ARM
> > consolidation everywhere, I'll be more brave :)
> >
> > What we have here is consolidation of two platforms. The older one, plat-stmp,
> > has never seen much love after the initial commit and has poor design as stated
> > in the patch descriptions. The recently added mach-mxs can be used for a
> > (friendly) takeover. Adding 130 lines there could save 9500+ lines in arch/arm!
> 
> may we FIRST see how you are going to fit it into mach-mxc? NAK from
> me before I see that.
I don't understand that nak. mach-mxs doesn't have to do anything with
plat-mxc codewise. (There are some similarities, e.g. both types of
machines are called i.MXYZ (which I consider to have marketing reasons).)

> BTW, I understand that you are taking steps in the right direction but
> having worked with stmp3xxx and multiple i.MXs, I see it as a great
> pity that a low-end but stable and convenient platform has been
> effectively killed by a semiconductor giant to avoid competition with
> unstable and painful to work with lower end i.MXs, and is also being
> killed virtually -- by you guys.
This shouldn't be in the way when doing software consolidation. Note
that the functionality isn't removed, so you should still be able to add
machines based on the original Sigmatel SoCs.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
