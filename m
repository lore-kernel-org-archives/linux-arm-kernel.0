From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 3 Apr 2015 22:18:46 +0200
Subject: [PATCH v3 4/5] i2c: davinci: use bus recovery infrastructure
In-Reply-To: <550C67D6.3080909@linaro.org>
References: <1417448047-15236-1-git-send-email-grygorii.strashko@ti.com>
 <1417448047-15236-5-git-send-email-grygorii.strashko@ti.com>
 <20150318203151.GA12072@katana> <550C67D6.3080909@linaro.org>
Message-ID: <20150403201846.GH2016@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > The I2C specs say in 3.1.16 that the recovery procedure should be used
> > when SDA is stuck low. So, I do wonder if we should apply the recovery
> > after a timeout. Stuck SDA might be one reason for timeout, but there
> > may be others...
> 
> This is ancient code. And regarding your question -
> Might be it would be reasonable to add call of
> i2c_davinci_wait_bus_not_busy() at the end of i2c_davinci_xfer()?
> This way we will wait for Bus Free before performing recovery.

That might be an improvement, but the generic question still remains:
Is a timeout a reason for recovery? SDA stuck low is one reason for a
timeout. I have problems making up my mind here between being pragmatic
and being in accordance with the specs.

> Of course,  i2c_davinci_wait_bus_not_busy() has to be fixed first
> as proposed by Alexander Sverdlin here:
>  https://patchwork.ozlabs.org/patch/448994/. 

Okay, good that you said it. So I'll give his patch series priority over
this one.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150403/fb2a1bff/attachment.sig>
