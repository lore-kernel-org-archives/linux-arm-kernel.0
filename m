From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 20 May 2014 17:11:31 +0100
Subject: [PATCH v2 2/4] mfd: bcm590xx: add support for secondary I2C
 slave address
In-Reply-To: <20140428140910.GB7719@beef>
References: <1398295293-11033-1-git-send-email-mporter@linaro.org>
 <1398295293-11033-3-git-send-email-mporter@linaro.org>
 <20140428115627.GY21279@lee--X1> <20140428140910.GB7719@beef>
Message-ID: <20140520161131.GB32025@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > BCM590xx utilizes a secondary I2C slave address to access additional
> > > register space. Add support for the secondary address space by
> > > instantiating a dummy I2C device with the appropriate secondary
> > > I2C slave address. Also expose a secondary regmap register space so
> > > that MFD drivers can access this secondary i2c slave address space.
> > > 
> > > Signed-off-by: Matt Porter <mporter@linaro.org>
> > > ---
> > >  drivers/mfd/bcm590xx.c       | 60 +++++++++++++++++++++++++++++++++-----------
> > >  include/linux/mfd/bcm590xx.h |  9 ++++---
> > >  2 files changed, 52 insertions(+), 17 deletions(-)
> > 
> > Nice, flows much better now.
> > 
> > Can I just apply the two MFD patches, or are there cross-deps?
> 
> There's cross-deps so the regulator driver will need to go with it.
> Mark mentioned earlier in the thread that he wanted to merge through
> the regulator tree though.

Still nothing.

Mark,
  Can I apply this set and supply you with a pull-request?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
