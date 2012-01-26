From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 26 Jan 2012 13:02:33 +0100
Subject: [PATCH 3/3] ARM: mx3: Let mx31 and mx35 enter in LPM mode in WFI
In-Reply-To: <1327084990-25402-3-git-send-email-fabio.estevam@freescale.com>
References: <1327084990-25402-1-git-send-email-fabio.estevam@freescale.com>
 <1327084990-25402-3-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20120126120233.GJ5446@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2012 at 04:43:10PM -0200, Fabio Estevam wrote:
> The LPM field of register CCMR is used to select the mode that the processor will run
> when it goes to WFI.
> 
> When mx31 enters in WFI mode the LPM field is at its reset value of 0,
> which configures the mx31 to enter in "wait mode".
> 
> On mx35, the LPM field on mx35 is also at 0 after reset, which corresponds 
> to "run mode" instead of "wait mode".
> 
> Instead of relying on the reset value of LPM to set the low power mode for
> WFI, configure mx31 and mx35 to run in "wait mode"

Do you consider this for -rc?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
