From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 15 Aug 2013 14:13:40 +0200
Subject: [PATCH v5 1/3] i2c-mv64xxx: Add I2C Transaction Generator support
In-Reply-To: <1376039158-1896-2-git-send-email-gregory.clement@free-electrons.com>
References: <1376039158-1896-1-git-send-email-gregory.clement@free-electrons.com>
 <1376039158-1896-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130815121340.GB17155@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> +	if ((msg->flags & I2C_M_RD) == 0) {
> +		for (i = 0; i < 4 && i < msg->len; i++)
> +			data_reg_lo = data_reg_lo |
> +					(msg->buf[i] << ((i & 0x3) * 8));
> +
> +		for (i = 4; i < 8 && i < msg->len; i++)
> +			data_reg_hi = data_reg_hi |
> +					(msg->buf[i] << ((i & 0x3) * 8));

Same comment as in the last version: What about be32_to_cpu and friends
instead of the loops (here and later)?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130815/4b3717e9/attachment.sig>
