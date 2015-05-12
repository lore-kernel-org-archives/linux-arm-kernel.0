From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 12 May 2015 21:24:13 +0200
Subject: [PATCH v2 10/17] i2c: add locomo i2c driver
In-Reply-To: <1430178954-11138-11-git-send-email-dbaryshkov@gmail.com>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
 <1430178954-11138-11-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20150512192413.GE4449@schokonusskuchen.bad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 28, 2015 at 02:55:47AM +0300, Dmitry Eremin-Solenikov wrote:
> LoCoMo chip contains a tiny i2c controller destined to control
> M62332 DAC. Provide a separate I2C driver for this cell.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Thanks for the submission!

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/mfd/locomo.h>
> +
> +#include <linux/i2c.h>
> +#include <linux/i2c-algo-bit.h>

To avoid duplicates, I prefer the includes to be sorted. No need to
resend because of that, though.

Kudos for brushing up old code! Do you want the drivers go via the
subsystem trees? Or is there a dependency so it should go in via some
other tree in one go?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150512/231ff613/attachment.sig>
