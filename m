From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 7 May 2012 17:54:50 +0100
Subject: [PATCH 06/15] mfd/ab8500: Remove confusing ab8500-i2c file and
 merge into ab8500-core
In-Reply-To: <1336155805-18554-7-git-send-email-lee.jones@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-7-git-send-email-lee.jones@linaro.org>
Message-ID: <20120507165450.GM17002@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2012 at 07:23:16PM +0100, Lee Jones wrote:
> ab8500-i2c is used as core code to register the ab8500 device.
> After allocating ab8500 memory, it immediately calls into
> ab8500-core where the real initialisation takes place. This
> patch moves all core registration and memory allocation into
> the true ab8500-core file and removes ab8500-i2c completely.

This idiom is commonly used as many devices support both I2C and SPI
control interfaces.  Does this apply here, or does the device only
support I2C?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120507/1039d0a7/attachment.sig>
