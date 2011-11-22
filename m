From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 22 Nov 2011 09:23:14 +0100
Subject: [RFC PATCH 0/3] Convert imx6 clock to device tree
In-Reply-To: <1321926536-671-1-git-send-email-shawn.guo@linaro.org>
References: <1321926536-671-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20111122082314.GB27267@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 09:48:53AM +0800, Shawn Guo wrote:
> As I promised to Arnd, I will convert imx6 clock code to common clock
> framework and in turn device tree at the earliest time.  Here it is.

Very nice ;) I like the patches.

Is there a way to improve the way how the entities find their base
addresses? Currently the C code figures out the base addresses based
on compatible. Maybe we could put the crm clocks and anatop clocks into
two different nodes instead of putting them all directly under clocks{}.

Could you split the last patch into two, one adding new device tree
clock support in a new file and another removing the old clock support?
This would help reviewing.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
