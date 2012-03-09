From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 9 Mar 2012 16:03:26 +0800
Subject: [RFC] i.MX: drop secondary clocks
In-Reply-To: <1331242949-22780-1-git-send-email-s.hauer@pengutronix.de>
References: <1331242949-22780-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120309080324.GN2499@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2012 at 10:42:27PM +0100, Sascha Hauer wrote:
> Hi All,
> 
> On i.MX we currently have grouped clocks, also known as secondary clocks.
> These are clocks that get enabled when the primary clock gets enabled.  This
> doesn't integrate well into the generic clock framework. Also we often return
> the rate of one clock and really enable/disable another clock. I plan to get
> rid of these clocks by exposing the individual clocks to the drivers. The
> following is meant as an example how this can be done. I have a more complete
> series internally but this conflicts with Richards clk_prepare series.
> 
> Thanks to the nature of clk_get we can simply clk_get the individual clocks in
> the drivers and the current clock implementation will always return the one
> with con_id = NULL. Then with the generic clk implementation the drivers will
> finally get the individual clocks.
> 
> So unless there are objections I will follow up on this after the next merge
> window.
> 
So glad to see you are getting rid of this nasty imx secondary clock.
I agree this is the way to go.

-- 
Regards,
Shawn
