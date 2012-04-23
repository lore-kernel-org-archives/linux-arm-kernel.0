From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 23 Apr 2012 08:54:19 +0200
Subject: [PATCH 32/40] ARM i.MX5: implement clocks using common clock
 framework
In-Reply-To: <20120423063949.GB15656@b20223-02.ap.freescale.net>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
 <1334065553-7565-33-git-send-email-s.hauer@pengutronix.de>
 <20120423063949.GB15656@b20223-02.ap.freescale.net>
Message-ID: <20120423065419.GZ3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 02:39:50PM +0800, Richard Zhao wrote:
> Hello Sascha,
> 
> I saw some code removed from clk init code. For example:
> mx51_clocks_init:
> clk_enable(&cpu_clk);
> clk_enable(&main_bus_clk);
> /* move usb_phy_clk to 24MHz */
> clk_set_parent(&usb_phy1_clk, &osc_clk);
> /* set the usboh3_clk parent to pll2_sw_clk */
> clk_set_parent(&usboh3_clk, &pll2_sw_clk);
> 
> mx53_clocks_init:
> clk_set_parent(&uart_root_clk, &pll3_sw_clk);
> 
> Could you explain why you remove them?
> If it has reasonable purpose, do you think it's better to put
> them in a seperate patch? It makes everyone clear what it changed.

I can readd most of them, the setup simply got lost. BTW what is the
reason for reparenting the uart clock in the i.MX53 setup? This will
break early console support if the bootloader didn't setup the uart
clock in the same way already.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
