From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 1 Sep 2010 10:15:19 +0100
Subject: [PATCH v2] MAX8952 PMIC Driver Initial Release
In-Reply-To: <011b01cb496a$cfa773d0$6ef65b70$%kim@samsung.com>
References: <1282283036-12641-1-git-send-email-myungjoo.ham@samsung.com>
	<20100820095351.GD13668@rakim.wolfsonmicro.main>
	<1282301229.3084.152.camel@odin>
	<011b01cb496a$cfa773d0$6ef65b70$%kim@samsung.com>
Message-ID: <20100901091519.GA17032@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 01, 2010 at 09:15:36AM +0900, Kukjin Kim wrote:

> Seems almost same between the operation of max8649 and max8952 except output
> voltage range.

> How do you think that can support max8952 with small modifying max8649?

Take a look at something like the WM831x drivers for how you can handle
multiple devices with one driver - you can register I2C IDs for multiple
devices and then select behaviour based on the name that was quoted.
