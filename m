From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 9 Nov 2012 14:58:26 +0000
Subject: [PATCH 5/6] ARM i.MX: rename ssi1 clock for imx27
In-Reply-To: <1352469625-32024-6-git-send-email-s.trumtrar@pengutronix.de>
References: <1352469625-32024-1-git-send-email-s.trumtrar@pengutronix.de>
 <1352469625-32024-6-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <20121109145825.GI23807@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 09, 2012 at 03:00:24PM +0100, Steffen Trumtrar wrote:

> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

You don't say anything about why you're renaming here...

> -	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "imx-ssi.0");
> +	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "10010000.ssi");
>  	clk_register_clkdev(clk[ssi2_ipg_gate], NULL, "imx-ssi.1");

I'm guessing this is for DT...  why are we only renaming one of the
clocks here and will this not break non-DT users?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121109/ec93c81b/attachment.sig>
