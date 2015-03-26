From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 26 Mar 2015 19:55:37 +0100
Subject: [PATCH 04/13] thermal: Fix not emulating critical temperatures
In-Reply-To: <55144C5B.7070208@ti.com>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-5-git-send-email-s.hauer@pengutronix.de>
 <55144C5B.7070208@ti.com>
Message-ID: <20150326185537.GM9742@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Cc Amit who implemented the emulation code.

On Thu, Mar 26, 2015 at 02:13:47PM -0400, Carlos Hernandez wrote:
> On 03/26/2015 11:53 AM, Sascha Hauer wrote:
> >- The code should only accept an emulated temperature when the emulated
> >   temperature is lower than the critical temperature. Instead the code
> 
> Why?
> Emulating temperatures higher than critical temperature is useful
> for testing. For instance it allows one to validate that critical
> action (i.e. shutdown) is triggered.

Not emulating critical temperatures was the intention of the original
patch adding the emulation code, but it was implemented wrongly. I just
fix to the intended behaviour.
However, I also find emulating critical temperatures useful. I could
also remove the check instead of fixing it if we can agree on that
behaviour.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
