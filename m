From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 26 Nov 2012 11:45:11 +0000
Subject: [PATCH 1/2] ASoC: davinci-mcasp: Add pinctrl support
In-Reply-To: <1353557099-21599-2-git-send-email-gururaja.hebbar@ti.com>
References: <1353557099-21599-1-git-send-email-gururaja.hebbar@ti.com>
 <1353557099-21599-2-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <20121126114511.GE9411@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2012 at 09:34:58AM +0530, Hebbar, Gururaja wrote:

> +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> +	if (IS_ERR(pinctrl))
> +		dev_warn(&pdev->dev,
> +			"pins are not configured from the driver\n");

Since the driver is happy to continue without the pins why is it
bothering requesting them in the first place?  In other words, this
should be a hard error.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121126/a82d85f5/attachment.sig>
