From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 13 Jul 2012 15:14:18 +0800
Subject: [PATCH 5/7] ARM: mxs: convert tx28 board to device tree
In-Reply-To: <20474.55029.733084.749955@ipc1.ka-ro>
References: <1341814496-17487-1-git-send-email-shawn.guo@linaro.org>
 <1341814496-17487-6-git-send-email-shawn.guo@linaro.org>
 <20474.55029.733084.749955@ipc1.ka-ro>
Message-ID: <20120713071415.GA10602@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar,

On Mon, Jul 09, 2012 at 03:04:53PM +0200, Lothar Wa?mann wrote:
> This doesn't work at least because the pins that are used for PHY
> strap options need to be reconfigured for their FEC functionality
> after releasing the PHY reset. But even after adding the missing
> reconfiguration the ethernet PHY does not work.
> 
Can you please test the branch below to see if ethernet PHY works?

  git://git.linaro.org/people/shawnguo/linux-2.6.git mxs/dt/tx28

I hope I have addressed the issue with pin configuration there.
But I'm not sure if "enet_out" clock needs to be enabled on tx28.
I have enabled it in the code above.  You need to remove
enable_clk_enet_out call from tx28_init, if it's not needed.

-- 
Regards,
Shawn
