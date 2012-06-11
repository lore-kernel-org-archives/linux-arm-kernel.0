From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 11 Jun 2012 17:41:34 +0800
Subject: [PATCH 1/2] ARM i.MX51: setup mipi
In-Reply-To: <20120609113220.GJ30400@pengutronix.de>
References: <1338888630-25930-1-git-send-email-s.hauer@pengutronix.de>
 <1338888630-25930-2-git-send-email-s.hauer@pengutronix.de>
 <20120607025949.GM2667@S2101-09.ap.freescale.net>
 <20120607081300.7a554215@archvile>
 <CAAQ0ZWQX60YWvEi-cWtTouMoxg1WxWo_soHf+4gE7oXsPfC_1g@mail.gmail.com>
 <20120607084336.GE30400@pengutronix.de>
 <20120607133734.GA3750@S2101-09.ap.freescale.net>
 <20120609113220.GJ30400@pengutronix.de>
Message-ID: <20120611094132.GH2552@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 09, 2012 at 01:32:20PM +0200, Sascha Hauer wrote:
> Do you have an idea what kind of API such a reset unit should export?
> Are you thinking about some kind of reset_me(struct device *dev) or
> what else?
> 
Yeah, that works for me.  We can have sub-nodes under SRC node in device
tree representing reset register and bit for those peripherals, and have
a phandle like "fsl,reset-handler" under peripheral nodes pointing to
the sub-nodes.

-- 
Regards,
Shawn
