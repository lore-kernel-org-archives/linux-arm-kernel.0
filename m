From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 9 Jul 2012 22:18:26 +0800
Subject: [PATCH 5/7] ARM: mxs: convert tx28 board to device tree
In-Reply-To: <20474.55029.733084.749955@ipc1.ka-ro>
References: <1341814496-17487-1-git-send-email-shawn.guo@linaro.org>
 <1341814496-17487-6-git-send-email-shawn.guo@linaro.org>
 <20474.55029.733084.749955@ipc1.ka-ro>
Message-ID: <20120709141824.GA18874@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 09, 2012 at 03:04:53PM +0200, Lothar Wa?mann wrote:
> This doesn't work at least because the pins that are used for PHY
> strap options need to be reconfigured for their FEC functionality
> after releasing the PHY reset.

Ah, right.  I missed that the pins used for PHY strap options are
actually FEC pins.

> But even after adding the missing
> reconfiguration the ethernet PHY does not work.
> 
How did you do that?  Since the pins will be switched between GPIO and
FEC functionality, they should not be defined in "hog" node any more.
It becomes difficult.

> Since I currently don't have time to delve deeper into this, you may
> drop the TX28 board support until I get time to do the conversion to
> DT myself.
> 
I plan to convert all the board files to DT and make the whole mach-mxs
DT only, and then more cleanup works can be proceeded.  It's much
preferred you can work on it yourself, if you can get to this soon.
Otherwise, I can remotely work it out with your help on testing? ;)

-- 
Regards,
Shawn
