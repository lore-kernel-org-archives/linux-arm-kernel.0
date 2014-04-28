From: mporter@linaro.org (Matt Porter)
Date: Mon, 28 Apr 2014 10:09:10 -0400
Subject: [PATCH v2 2/4] mfd: bcm590xx: add support for secondary I2C
 slave address
In-Reply-To: <20140428115627.GY21279@lee--X1>
References: <1398295293-11033-1-git-send-email-mporter@linaro.org>
 <1398295293-11033-3-git-send-email-mporter@linaro.org>
 <20140428115627.GY21279@lee--X1>
Message-ID: <20140428140910.GB7719@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 12:56:27PM +0100, Lee Jones wrote:
> On Wed, 23 Apr 2014, Matt Porter wrote:
> 
> > BCM590xx utilizes a secondary I2C slave address to access additional
> > register space. Add support for the secondary address space by
> > instantiating a dummy I2C device with the appropriate secondary
> > I2C slave address. Also expose a secondary regmap register space so
> > that MFD drivers can access this secondary i2c slave address space.
> > 
> > Signed-off-by: Matt Porter <mporter@linaro.org>
> > ---
> >  drivers/mfd/bcm590xx.c       | 60 +++++++++++++++++++++++++++++++++-----------
> >  include/linux/mfd/bcm590xx.h |  9 ++++---
> >  2 files changed, 52 insertions(+), 17 deletions(-)
> 
> Nice, flows much better now.
> 
> Can I just apply the two MFD patches, or are there cross-deps?

There's cross-deps so the regulator driver will need to go with it.
Mark mentioned earlier in the thread that he wanted to merge through
the regulator tree though.

-Matt
