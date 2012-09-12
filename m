From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Wed, 12 Sep 2012 12:21:49 +0530
Subject: [PATCHv7 18/23] i2c: omap: remove redundant status read
In-Reply-To: <20120911215441.GC27031@pengutronix.de>
References: <1347356538-23835-1-git-send-email-shubhrajyoti@ti.com>
 <1347356538-23835-19-git-send-email-shubhrajyoti@ti.com>
 <20120911215441.GC27031@pengutronix.de>
Message-ID: <50503105.8050100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 September 2012 03:24 AM, Wolfram Sang wrote:
> On Tue, Sep 11, 2012 at 03:12:13PM +0530, Shubhrajyoti D wrote:
>> Remove the redundant read of the status register.
> Commit message is just repeating the subject.
> Why was the read there and why can it be removed now?
>
It is read and it is not read anywhere below.
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>> ---
>>  drivers/i2c/busses/i2c-omap.c |    2 --
>>  1 files changed, 0 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>> index 5d4bad4..498a462 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -946,7 +946,6 @@ omap_i2c_isr(int this_irq, void *dev_id)
>>  				num_bytes = dev->buf_len;
>>  
>>  			ret = omap_i2c_transmit_data(dev, num_bytes, true);
>> -			stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
>>  			if (ret < 0)
>>  				goto out;
>>  
>> @@ -962,7 +961,6 @@ omap_i2c_isr(int this_irq, void *dev_id)
>>  				num_bytes = dev->threshold;
>>  
>>  			ret = omap_i2c_transmit_data(dev, num_bytes, false);
>> -			stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
>>  			if (ret < 0)
>>  				goto out;
>>  
>> -- 
>> 1.7.5.4
>>
