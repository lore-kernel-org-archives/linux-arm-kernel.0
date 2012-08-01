From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 1 Aug 2012 15:50:12 +0800
Subject: [06/10,V2] spi: Add SPI driver for mx233/mx28
In-Reply-To: <20120801065650.GA2928@roeck-us.net>
References: <1341555449-17507-6-git-send-email-marex@denx.de>
 <201208010810.37652.marex@denx.de>
 <20120801063936.GC2764@roeck-us.net>
 <201208010845.19361.marex@denx.de>
 <20120801065650.GA2928@roeck-us.net>
Message-ID: <20120801075010.GI1672@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 11:56:50PM -0700, Guenter Roeck wrote:
> Guess we are in violent agreement. The sequence would then either be
> 	master = spi_alloc_device();

The discussion is around spi_alloc_master rather than spi_alloc_device,
isn't it?

Regards,
Shawn

> 	...
> 	spi_master_put(master);
> or
> 	master = spi_alloc_device();
> 	...
> 	kfree(master);
> 
> which makes sense to me. Question still is why most drivers neither call kfree()
> nor spi_master_put() in the remove function.
