From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 Jun 2012 08:23:49 +0100
Subject: [PATCH 09/14] i2c: Add Device Tree support to the Nomadik I2C
 driver
In-Reply-To: <20120611190550.GK3887@pengutronix.de>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-10-git-send-email-lee.jones@linaro.org>
 <20120611190550.GK3887@pengutronix.de>
Message-ID: <4FD6EE85.2090207@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/12 20:05, Wolfram Sang wrote:
> On Mon, Jun 11, 2012 at 04:25:02PM +0100, Lee Jones wrote:
>> Here we move the i2c-nomadik's default settings into the driver
>> rather than specifying them from platform code. At the time of
>> this writing we only have one user, the u8500. As new users are
>> added, it is expected that they will be Device Tree compliant.
>> If this is the case, we will look up their initialisation values
>> by compatible entry, then apply them forthwith.
>>
>> Cc: linux-i2c at vger.kernel.org
>> Acked-by: Linus Walleij<linus.walleij@linaro.org>
>> Signed-off-by: Lee Jones<lee.jones@linaro.org>
>> ---
>>   drivers/i2c/busses/i2c-nomadik.c |   40 +++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 39 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
>> index a92440d..1ffdf67 100644
>> --- a/drivers/i2c/busses/i2c-nomadik.c
>> +++ b/drivers/i2c/busses/i2c-nomadik.c
>> @@ -23,6 +23,7 @@
>>   #include<linux/io.h>
>>   #include<linux/regulator/consumer.h>
>>   #include<linux/pm_runtime.h>
>> +#include<linux/of_device.h>
>>
>>   #include<plat/i2c.h>
>>
>> @@ -899,15 +900,51 @@ static const struct i2c_algorithm nmk_i2c_algo = {
>>   	.functionality	= nmk_i2c_functionality
>>   };
>>
>> +static struct nmk_i2c_controller u8500_i2c = {
>> +       /*
>> +        * slave data setup time, which is
>> +        * 250 ns,100ns,10ns which is 14,6,2
>> +        * respectively for a 48 Mhz
>> +        * i2c clock
>> +        */
>> +       .slsu           = 0xe,
>> +       /* Tx FIFO threshold */
>
> Please put these comments directly after the members they describe.
>
> And make sure you use tabs for indentation all over the patch instead of
> spaces. checkpatch.pl will help you to get the formal things right.

My apologies. This section of code was a direct copy and paste from 
platform code (arch/arm/mach-ux500/board-mop500.c). It must have lost 
some formatting en route. I'll make the changes you request and re-post.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
