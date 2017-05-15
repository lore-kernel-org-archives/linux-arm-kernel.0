From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 15 May 2017 19:47:39 +0200 (CEST)
Subject: [PATCH] clk: bcm2835: Correct the prediv logic
In-Reply-To: <20170515173504.11337-1-eric@anholt.net>
References: <20170515173504.11337-1-eric@anholt.net>
Message-ID: <1373231207.445862.1494870459462@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

> Eric Anholt <eric@anholt.net> hat am 15. Mai 2017 um 19:35 geschrieben:
> 
> 
> From: Phil Elwell <phil@raspberrypi.org>
> 
> If a clock has the prediv flag set, both the integer and fractional
> parts must be scaled when calculating the resulting frequency.
> 
> Signed-off-by: Phil Elwell <phil@raspberrypi.org>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
> 
> While this is a bugfix, I haven't put a "Fixes:" line in here to get
> it automatically backported to stable.  

sorry, i can't follow. How should this happen without "Fixes: "?

> We had trouble with the
> out-of-tree DSI panel driver, at least: Our old set_rate() didn't
> work, because the new PLL was just barely too fast to get the integer
> PLL divider we needed.  We may run into similar troubles
> elsewhere. --anholt
>
