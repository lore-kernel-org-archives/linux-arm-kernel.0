From: b32955@freescale.com (Huang Shijie)
Date: Mon, 15 Jul 2013 16:41:25 +0800
Subject: [PATCH 2/3] serial: mxs: enable the DMA only when the rts/cts
 is enabled
In-Reply-To: <20130715082716.GM12139@pengutronix.de>
References: <1373857736-30108-1-git-send-email-b32955@freescale.com>
 <1373857736-30108-2-git-send-email-b32955@freescale.com>
 <20130715082716.GM12139@pengutronix.de>
Message-ID: <51E3B5B5.1030706@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?07?15? 16:27, Uwe Kleine-K?nig ??:
> do you want to say that the driver fails to only enable DMA when RTS/CTS
> are available; or that today the driver can handle DMA just fine even
> without RTS/CTS? I interpret your commit log as the latter, your patch
> implements the former however.
in the mxs-auart, if the RTS/CTS is not invalid, the DMA should be not 
enabled.

But current code lost the limit, a uart without the RTS/CTS may also 
enables the DMA in which case the uart
may does not run or run in a abnormal way.

thanks
Huang Shijie
