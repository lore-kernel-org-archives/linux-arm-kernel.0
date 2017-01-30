From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 30 Jan 2017 18:44:04 +0100
Subject: [PATCH] i2c: at91: ensure state is restored after suspending
In-Reply-To: <20170130172533.31995-1-alexandre.belloni@free-electrons.com>
References: <20170130172533.31995-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170130174403.GA3282@tetsubishi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> +	at91_init_twi_bus(twi_dev);

Can't this function reinit the registers to the needed values? I am not
convinced that a cache will always reflect the proper state after
resume.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170130/dcf9101f/attachment.sig>
