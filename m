From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 2 Dec 2011 11:24:18 +0100
Subject: Building of arch/arm/plat-mxc/ssi-fiq.S failed w/ THUMB2 enabled?
In-Reply-To: <CAMPhdO_4NQUFB14eecTb3N4oQJa86ojSk8FUveqg+Lye5_jY+A@mail.gmail.com>
References: <CAMPhdO_4NQUFB14eecTb3N4oQJa86ojSk8FUveqg+Lye5_jY+A@mail.gmail.com>
Message-ID: <20111202102418.GT26618@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2011 at 06:01:08PM +0800, Eric Miao wrote:
> Hi Dave & Sascha,
> 
> I checked the log of this file, found a THUMB2 related changes, yet
> I'm still having the failure below, can you help do a quick check?
the problem is that in Thumb most commands don't work with r8-r15
because there are only three bits used to encode them. This is
unfortunate as the other registers are not banked for FIQ.

The best possibility I see is to save some unbanked registers to the
banked registers on entry and restore them on exception exit.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
