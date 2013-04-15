From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 15 Apr 2013 18:06:51 +0200
Subject: [PATCH] i2c: s3c2410: Add SMBus emulation for block read
In-Reply-To: <20130409122313.GD4913@pengutronix.de>
References: <1364308196-10101-1-git-send-email-prasanna.ps@samsung.com>
 <20130409122313.GD4913@pengutronix.de>
Message-ID: <20130415160651.GA6286@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> I don't know if that can happen, but if the block has length 0 (that is,
> only consists of a single byte that is read as 0) the is_msglast() test
> returns 0 which might be wrong. Maybe even if it cannot regularily
> happen handle it in a sane way?

Length of 0 is illegal according to the specs, but a check won't hurt.

> Also I wonder if error checking for byte > I2C_SMBUS_BLOCK_MAX would be
> needed to prevent a buffer overrun?

Yes. Although I have seen devices able to send more than that, yet
adding support for that is a seperate issue.
