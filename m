From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 15 Oct 2012 10:03:11 -0600
Subject: [PATCH v2] i2c: i2c-gpio: fix name issue when i2c gpio node GT 1
In-Reply-To: <1350287477-30936-1-git-send-email-voice.shen@atmel.com>
References: <1350287477-30936-1-git-send-email-voice.shen@atmel.com>
Message-ID: <507C33BF.6020604@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2012 01:51 AM, Bo Shen wrote:
> When i2c-gpio node number is greater than 1, the name for each is same
> So add the patch to fix it.
> 
> The adap->name printing information is add by myself
> 
> without this patch the log information is as following
> ---<8---
> adap->name = i2c-gpio-1
> i2c-gpio i2c.2: using pins 30 (SDA) and 31 (SCL)
> adap->name = i2c-gpio-1
> i2c-gpio i2c.3: using pins 64 (SDA) and 65 (SCL)
> --->8---
> 
> with this patch, the log information is as following
> ---<8---
> adap->name = i2c.2
> i2c-gpio i2c.2: using pins 30 (SDA) and 31 (SCL)
> adap->name = i2c.3
> i2c-gpio i2c.3: using pins 64 (SDA) and 65 (SCL)
> --->8---

I think this is reasonable, although I imagine this has zero effect on
the I2C bus number that's assigned to the device, so I'm not sure how it
interacts with or supports the other Atmel patch series you sent, which
I didn't really look at in much detail.

Reviewed-by: Stephen Warren <swarren@nvidia.com>
