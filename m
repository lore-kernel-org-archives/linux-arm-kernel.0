From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 3 Jun 2015 02:33:41 +0900
Subject: [PATCH 05/12] i2c: pxa: Add bus reset functionality
In-Reply-To: <1432818224-17070-6-git-send-email-vaibhav.hiremath@linaro.org>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1432818224-17070-6-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <20150602173341.GA1494@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Since there is some problematic i2c slave devices on some
> platforms such as dkb (sometimes), it will drop down sda
> and make i2c bus hang, at that time, it need to config
> scl/sda into gpio to simulate "stop" sequence to recover
> i2c bus, so add this interface.

Please note that the i2c core has a bus recovery infrastructure.
Search i2c.h for struct i2c_bus_recovery_info.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150603/352f0bd0/attachment.sig>
