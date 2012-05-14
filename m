From: josh.wu@atmel.com (Josh Wu)
Date: Mon, 14 May 2012 18:54:56 +0800
Subject: [PATCH v6] MTD: atmel_nand: Update driver to support Programmable
 Multibit ECC controller
In-Reply-To: <1336738300.2625.57.camel@sauron.fi.intel.com>
References: <1336561255-30905-1-git-send-email-josh.wu@atmel.com>
 <1336738300.2625.57.camel@sauron.fi.intel.com>
Message-ID: <4FB0E480.1070609@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Artem

On 5/11/2012 8:11 PM, Artem Bityutskiy wrote:
> On Wed, 2012-05-09 at 19:00 +0800, Josh Wu wrote:
>> The Programmable Multibit ECC (PMECC) controller is a programmable binary
>> BCH(Bose, Chaudhuri and Hocquenghem) encoder and decoder. This controller
>> can be used to support both SLC and MLC NAND Flash devices. It supports to
>> generate ECC to correct 2, 4, 8, 12 or 24 bits of error per sector of data.
>>
>> To use this driver, the user needs to pass in the correction capability and
>> the sector size.
>>
>> This driver has been tested on AT91SAM9X5-EK and AT91SAM9N12-EK with JFFS2,
>> YAFFS2, UBIFS and mtd-utils.
>>
>> Signed-off-by: Hong Xu<hong.xu@atmel.com>
>> Signed-off-by: Josh Wu<josh.wu@atmel.com>
> The patch is really big - please, split it on more smaller patches.

OK, I can spit to more patches.

> Besides, it does not compile for me:
>
> ERROR: "of_flat_dt_is_compatible" [drivers/mtd/nand/atmel_nand.ko] undefined!
> ERROR: "of_get_flat_dt_root" [drivers/mtd/nand/atmel_nand.ko] undefined!
> make[2]: *** [__modpost] Error 1

This function will depend on CONFIG_OF_FLATTREE and 
CONFIG_OF_EARLY_FLATTREE.

Would it be possible that CONFIG_OF is defined, but above two config 
options are not defined? Can I see you .config file go get more details?


Best Regards,
Josh Wu
