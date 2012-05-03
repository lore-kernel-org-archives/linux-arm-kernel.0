From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 3 May 2012 11:21:05 +0800
Subject: [PATCH 31/33] ARM i.MX5: implement clocks using common clock
 framework
In-Reply-To: <1335367703-19929-32-git-send-email-s.hauer@pengutronix.de>
References: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
 <1335367703-19929-32-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120503032102.GG2194@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

Can you fix the ssi clocks below before you send it to Arnd?  Or I will
send a fix to patch it later.

On Wed, Apr 25, 2012 at 05:28:21PM +0200, Sascha Hauer wrote:
> +	clk[ssi1_ipg_gate] = imx_clk_gate2("ssi1_ipg_gate", "ipg", MXC_CCM_CCGR3, 16);
> +	clk[ssi2_ipg_gate] = imx_clk_gate2("ssi2_ipg_gate", "ipg", MXC_CCM_CCGR3, 18);
s/18/20
> +	clk[ssi3_ipg_gate] = imx_clk_gate2("ssi3_ipg_gate", "ipg", MXC_CCM_CCGR3, 20);
s/20/24

> +	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "imx-ssi.0");
> +	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "imx-ssi.1");
ssi2_ipg_gate
> +	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "imx-ssi.2");
ssi3_ipg_gate

-- 
Regards,
Shawn
