From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Mar 2012 11:50:33 -0800
Subject: [PATCH] plat-omap: mcbsp: Configure wakeup in later phase
In-Reply-To: <1323941697-7902-1-git-send-email-peter.ujfalusi@ti.com>
References: <1323941697-7902-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120305195032.GO12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter,

* Peter Ujfalusi <peter.ujfalusi@ti.com> [111215 01:03]:
> Configure the WAKEUPEN register at the same time we configure the rest of
> the McBSP registers.
> In case of OMAP3+, if the sysclock has been reconfigured we are going to
> disable McBSP for the duration of the clock change, which will reset the
> McBSP registers. The WAKEUPEN register need to be configured later, so
> the changes will be effective during runtime.

Just checking.. I assume this one is already taken care of with your
other McBSP changes?

Tony
