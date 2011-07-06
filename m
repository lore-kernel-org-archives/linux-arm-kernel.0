From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 6 Jul 2011 11:06:37 +0200
Subject: [PATCH] Add 'config IMX_NFC_V1_BISWAP' to swap the Bad block
	Indicator, and use for imx27pdk nand support.
In-Reply-To: <1309872828-13942-1-git-send-email-J.Lambrecht@televic.com>
References: <1309872828-13942-1-git-send-email-J.Lambrecht@televic.com>
Message-ID: <20110706090637.GA2117@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> +	temp1 = *((volatile unsigned short*)(host->main_area0 + 0x7D0));
> +	temp2 = *((volatile unsigned short*)(host->main_area0 + 0x834));
> +	new_temp1 = (temp1 & 0xFF00) | (temp2 >> 8);
> +	temp2 = (temp2 & 0x00FF) | (temp1 << 8);
> +	*((volatile unsigned short*)(host->main_area0 + 0x7D0)) = new_temp1;
> +	*((volatile unsigned short*)(host->main_area0 + 0x834)) = temp2;

Please use proper io-accessors and no magic values in V2.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110706/c3f9bebd/attachment.sig>
