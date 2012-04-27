From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 27 Apr 2012 11:51:56 -0300
Subject: [PATCH] i2c: mxs: disable QUEUE when sending is done
In-Reply-To: <1335536631-28202-1-git-send-email-w.sang@pengutronix.de>
References: <1335536631-28202-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <CAOMZO5A1_Z7T5md61OJWmXbx2qCjFEByjyGvjhxqhfxzwfLEVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Fri, Apr 27, 2012 at 11:23 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:

> ? ? ? ?if (i2c->cmd_err == -ENXIO)
> ? ? ? ? ? ? ? ?mxs_i2c_reset(i2c);
> + ? ? ? else
> + ? ? ? ? ? ? ? writel(MXS_I2C_QUEUECTRL_QUEUE_RUN,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? i2c->regs + MXS_I2C_QUEUECTRL_CLR);

When setting the QUEUE_RUN, do we really want to clear all the other
bits of QUEUECTRL_CLR register?

I am wondering if we should only set QUEUE_RUN bit here.

My mx28evk does not come with i2c eeprom. I hope I will solder one
soon so I can test it.

Thanks,

Fabio Estevam
