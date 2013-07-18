From: broonie@kernel.org (Mark Brown)
Date: Thu, 18 Jul 2013 21:49:56 +0100
Subject: [PATCH v2 01/24] spi: mpc512x: cleanup clock API use
In-Reply-To: <1374166855-7280-2-git-send-email-gsi@denx.de>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
 <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374166855-7280-2-git-send-email-gsi@denx.de>
Message-ID: <20130718204956.GU22506@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 07:00:32PM +0200, Gerhard Sittig wrote:

> +	psc_num = master->bus_num;
> +	snprintf(clk_name, sizeof(clk_name), "psc%d_mclk", psc_num);
> +	mps->clk_mclk = clk_get(dev, clk_name);
> +	if (IS_ERR(mps->clk_mclk))
> +		goto free_irq;

Should be using devm_clk_get().
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130718/5428dd8f/attachment.sig>
