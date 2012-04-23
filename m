From: richard.zhao@freescale.com (Richard Zhao)
Date: Mon, 23 Apr 2012 14:39:50 +0800
Subject: [PATCH 32/40] ARM i.MX5: implement clocks using common clock
 framework
In-Reply-To: <1334065553-7565-33-git-send-email-s.hauer@pengutronix.de>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
 <1334065553-7565-33-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120423063949.GB15656@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sascha,

I saw some code removed from clk init code. For example:
mx51_clocks_init:
clk_enable(&cpu_clk);
clk_enable(&main_bus_clk);
/* move usb_phy_clk to 24MHz */
clk_set_parent(&usb_phy1_clk, &osc_clk);
/* set the usboh3_clk parent to pll2_sw_clk */
clk_set_parent(&usboh3_clk, &pll2_sw_clk);

mx53_clocks_init:
clk_set_parent(&uart_root_clk, &pll3_sw_clk);

Could you explain why you remove them?
If it has reasonable purpose, do you think it's better to put
them in a seperate patch? It makes everyone clear what it changed.
 
Thanks
Richard
 
