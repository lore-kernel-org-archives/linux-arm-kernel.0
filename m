From: sander@van-ginkel.eu (sander van ginkel)
Date: Fri, 30 Nov 2012 17:32:24 +0100
Subject: [PATCH] add hardware I2C support for ARM IMX23
In-Reply-To: <20121128170907.GC4659@pengutronix.de>
References: <20121128152403.45224dvyaufb1j7n@62.129.139.42>
 <20121128150851.GA4659@pengutronix.de>
 <20121128171039.14705ltphptrp5kv@62.129.139.42>
 <20121128162452.GB4659@pengutronix.de> <50B63F81.4050008@van-ginkel.eu>
 <20121128170907.GC4659@pengutronix.de>
Message-ID: <20121130173224.10203ha9fee3y36g@62.129.139.42>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> You might want to try my for-next branch or wait for 3.8-rc1, maybe
the
> DMA termination patch helps? Also enabling I2C debug messages is
> probably worth it.
>
> Regards,
>
>    Wolfram
>
> --
> Pengutronix e.K.                           | Wolfram Sang
      |
> Industrial Linux Solutions                 |
http://www.pengutronix.de/  |
>

I've tested your git tree, with the same config as I used for the  
3.7.0-rc6 release (IMX i2c build in)
It's not a 100% fix

If I do "i2cdetect -y -r 0" with 3.7.0-rc6, i2cdetect gets confused  
and the kernel keeps dumping "mxs-i2c 80058000.i2c: Failed to get PIO  
reg. write descriptor."
If I do the same with your git release I get the same result, but only  
when i2cdetect is running. When it's finished or I terminate, the  
kprint will also disappear.
So there is some improvement but not 100% yet.
