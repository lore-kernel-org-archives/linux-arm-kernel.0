From: b32955@freescale.com (Huang Shijie)
Date: Mon, 30 Jan 2012 18:32:35 +0800
Subject: [PATCH] mtd/gpmi : add BBT support
In-Reply-To: <20120130094610.GA15596@pengutronix.de>
References: <1327898174-13656-1-git-send-email-b32955@freescale.com>
 <20120130094610.GA15596@pengutronix.de>
Message-ID: <4F2671C3.6000809@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?01?30? 17:46, Wolfram Sang ??:
> On Mon, Jan 30, 2012 at 12:36:14PM +0800, Huang Shijie wrote:
>> add the BBT support to the gpmi nand driver.
>> Signed-off-by: Huang Shijie <b32955@freescale.com>
>> ---
>>  drivers/mtd/nand/gpmi-nand/gpmi-nand.c |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
>> index 493ec2f..4fbb341 100644
>> --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
>> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
>> @@ -1493,6 +1493,7 @@ static int __devinit gpmi_nfc_init(struct gpmi_nand_data *this)
>>  	chip->ecc.mode		= NAND_ECC_HW;
>>  	chip->ecc.size		= 1;
>>  	chip->ecc.layout	= &gpmi_hw_ecclayout;
>> +	chip->bbt_options	= NAND_BBT_USE_FLASH | NAND_BBT_NO_OOB;
> You are making this default. Is there a bootloader which supports that
> on MXS?
>
The bootloader usually is burned on /dev/mtd0, while the BBT is placed
at the end
of the NAND chip.

I tested the NAND boot mode too.

What's your concern?

Huang Shijie
