From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 28 Apr 2014 12:56:27 +0100
Subject: [PATCH v2 2/4] mfd: bcm590xx: add support for secondary I2C
 slave address
In-Reply-To: <1398295293-11033-3-git-send-email-mporter@linaro.org>
References: <1398295293-11033-1-git-send-email-mporter@linaro.org>
 <1398295293-11033-3-git-send-email-mporter@linaro.org>
Message-ID: <20140428115627.GY21279@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Apr 2014, Matt Porter wrote:

> BCM590xx utilizes a secondary I2C slave address to access additional
> register space. Add support for the secondary address space by
> instantiating a dummy I2C device with the appropriate secondary
> I2C slave address. Also expose a secondary regmap register space so
> that MFD drivers can access this secondary i2c slave address space.
> 
> Signed-off-by: Matt Porter <mporter@linaro.org>
> ---
>  drivers/mfd/bcm590xx.c       | 60 +++++++++++++++++++++++++++++++++-----------
>  include/linux/mfd/bcm590xx.h |  9 ++++---
>  2 files changed, 52 insertions(+), 17 deletions(-)

Nice, flows much better now.

Can I just apply the two MFD patches, or are there cross-deps?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
