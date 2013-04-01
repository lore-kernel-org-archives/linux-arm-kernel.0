From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 1 Apr 2013 14:38:33 +0100
Subject: [PATCH v7 01/14] spi/spi-atmel: detect the capabilities of SPI
 core by reading the VERSION register.
In-Reply-To: <1363678935-3665-1-git-send-email-wenyou.yang@atmel.com>
References: <1363678866-3567-1-git-send-email-wenyou.yang@atmel.com>
 <1363678935-3665-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20130401133833.GT18636@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 19, 2013 at 03:42:15PM +0800, Wenyou Yang wrote:

> +{
> +	unsigned int version;
> +
> +	version = atmel_get_version(as);
> +	dev_info(&as->pdev->dev, "version: 0x%x\n", version);
> +
> +	as->caps.is_spi2 = (version > 0x121) ? true : false;
> +	as->caps.has_wdrbt = (version >= 0x210) ? true : false;
> +	as->caps.has_dma_support = (version >= 0x212) ? true : false;
> +}
> +

There's absolutely no need for the ternery operators here - your
comparisons are already boolean, the ternery operators just add noise.

I've applied this with the above edited to remove the ? true : false,
thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130401/e96db89b/attachment.sig>
