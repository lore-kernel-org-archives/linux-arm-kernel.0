From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 28 Oct 2015 00:30:00 +0100
Subject: [PATCH v3 4/4] iio: humidity: si7020: added No Hold read mode
In-Reply-To: <1445976718-7449-4-git-send-email-nicola@corna.info>
References: <1445976718-7449-1-git-send-email-nicola@corna.info>
 <1445976718-7449-4-git-send-email-nicola@corna.info>
Message-ID: <20151027233000.GB1572@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Not a complete review, I just stumbled over this one:

> +			if (client->adapter->quirks &&
> +			   client->adapter->quirks->flags |

'|' should be '&', or?

> +			   I2C_AQ_NO_CLK_STRETCH)
> +				return -ENODEV;
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151028/0f7f2007/attachment.sig>
