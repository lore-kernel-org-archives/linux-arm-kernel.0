From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 3 Jan 2014 17:10:12 +0100
Subject: [PATCH V2] i2c: s3c2410 : Add polling mode support
In-Reply-To: <1384168820-2986-1-git-send-email-yuvaraj.cd@samsung.com>
References: <1384168820-2986-1-git-send-email-yuvaraj.cd@samsung.com>
Message-ID: <20140103161012.GH7132@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 11, 2013 at 04:50:20PM +0530, Yuvaraj Kumar C D wrote:
> From: Vasanth Ananthan <vasanthananthan@gmail.com>
> 
> This patch adds polling mode support for i2c-s3c2410 driver.The
> SATA PHY controller's CMU and TRSV block's are of I2C register
> map in exynos5250.These blocks can be configured using i2c.
> 
> But i2c controller instance on which these block's sits lacks an
> interrupt line.Also the current i2c-s3c2410 driver is only interrupt
> driven, thus a polling mode support is required in the driver for
> supporting this controller. This patch adds this support to the driver.
> 
> Changes from V1:
> 	1.Changed the is_ack() to have even period b/w polls and
> 	  used usleep_range() instead of udelay().

Mileages vary, but I'd like to see revision changes after the "---".

>  	ret = devm_request_irq(&pdev->dev, i2c->irq, s3c24xx_i2c_irq, 0,
> -			       dev_name(&pdev->dev), i2c);
> +				dev_name(&pdev->dev), i2c);

Unrelated change.

Rest looks good, so I'll fix up the things for you and apply to
for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140103/ee197629/attachment.sig>
