From: broonie@kernel.org (Mark Brown)
Date: Mon, 22 Jul 2013 15:09:04 +0100
Subject: [PATCH v3 01/31] spi: mpc512x: cleanup clock API use
In-Reply-To: <1374495298-22019-2-git-send-email-gsi@denx.de>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1374495298-22019-2-git-send-email-gsi@denx.de>
Message-ID: <20130722140904.GU9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 22, 2013 at 02:14:28PM +0200, Gerhard Sittig wrote:

> +	ret = clk_prepare_enable(clk);
> +	if (ret) {
> +		devm_clk_put(dev, clk);
> +		goto free_irq;

The main point of the devm_ APIs is to avoid the need for explicit
freeing so you should just remove these puts.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130722/d3cc5152/attachment.sig>
