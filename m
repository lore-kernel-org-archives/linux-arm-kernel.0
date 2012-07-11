From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 Jul 2012 20:46:55 +0200
Subject: [PATCH 3/3] ARM: i.MX5x clocks: Fix GPT clocks
In-Reply-To: <1341990699.130808521@f65.mail.ru>
References: <20120709082700.GM24458@pengutronix.de>
 <1341946469-25984-3-git-send-email-shc_work@mail.ru>
 <20120711064406.GF30009@pengutronix.de>
 <1341990699.130808521@f65.mail.ru>
Message-ID: <20120711184655.GN30009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2012 at 11:11:39AM +0400, Alexander Shiyan wrote:
> Hello.
> 
> 
> Wed, 11 Jul 2012 08:44:06 +0200 ?? Sascha Hauer <s.hauer@pengutronix.de>:
> On Tue, Jul 10, 2012 at 10:54:29PM +0400, Alexander Shiyan wrote:
> > This patch fix incorrect defined bits for GPT clocks according to
> > datasheet.
> 
> Fix is a strong word. As I can see it these are only cosmetic changes
> without any functional change, right?

> No. GPT bits for "per_root" and "ipg" was be swapped. IMX51RM says:
> CCGR2 Register Mappingi
> ...
> 9 gpt_ipg_clk
> 10 gpt_highfreq

Ah, ok. So it seems clk_get_rate will return the correct clock, but the
clk_enable() is mixed for both clocks. In this case I think this can
wait for the merge window since the current code will enable both clocks
anyway.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
