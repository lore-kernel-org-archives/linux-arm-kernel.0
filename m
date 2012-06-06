From: stigge@antcom.de (Roland Stigge)
Date: Wed, 06 Jun 2012 16:27:42 +0200
Subject: [PATCH v6] MTD: LPC32xx SLC NAND driver
In-Reply-To: <1338989921.6875.50.camel@sauron.fi.intel.com>
References: <1338974414-5308-1-git-send-email-stigge@antcom.de>
 <1338989921.6875.50.camel@sauron.fi.intel.com>
Message-ID: <4FCF68DE.6000701@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/06/2012 03:38 PM, Artem Bityutskiy wrote:
>> +#else +#define lpc32xx_nand_resume NULL +#define
>> lpc32xx_nand_suspend NULL +#endif
> 
> 0, not NULL.

Can you please point me to an explanation for this? NULL sounds
natural here, since it is used as a pointer, and other nand drivers
are already doing it via NULL:

bcm_umi_nand.c
bf5xx_nand.c
pxa3xx_nand.c
r852.c
s3c2410.c
tmio_nand.c
txx9ndfmc.c

... and none is #defining as 0.

Thanks in advance,

Roland
