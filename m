From: broonie@kernel.org (Mark Brown)
Date: Mon, 22 Dec 2014 14:28:02 +0000
Subject: [PATCH v3 4/5] ASoC: dwc: Add devicetree support for Designware
 I2S
In-Reply-To: <9699e11a566938b8d1821f9be3df3276d57cd979.1418826016.git.Andrew.Jackson@arm.com>
References: <cover.1418826016.git.Andrew.Jackson@arm.com>
 <9699e11a566938b8d1821f9be3df3276d57cd979.1418826016.git.Andrew.Jackson@arm.com>
Message-ID: <20141222142802.GU17800@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 19, 2014 at 04:18:08PM +0000, Andrew Jackson wrote:

>  	if (IS_ERR(dev->clk))
> -		return  PTR_ERR(dev->clk);
> +		return PTR_ERR(dev->clk);
> +
> +	ret = clk_prepare(dev->clk);
> +	if (ret < 0)
> +		goto err_clk_put;

This isn't adding device tree support, it's adding use of clk_prepare()
which is a separate change and is normally better done by converting to
use clk_prepare_enable().
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141222/f8d5f7f8/attachment.sig>
