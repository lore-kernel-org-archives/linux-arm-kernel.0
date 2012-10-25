From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Thu, 25 Oct 2012 15:04:29 +0530
Subject: [PATCH v2] i2c: omap: re-factor omap_i2c_init function
In-Reply-To: <20121025063608.GA5084@arwen.pp.htv.fi>
References: <1351147011-6500-1-git-send-email-shubhrajyoti@ti.com>
 <20121025063608.GA5084@arwen.pp.htv.fi>
Message-ID: <CAM=Q2ctcxO2eFFBDdF_Mwt1bm34pj5hvJW4AS6V-GQVTVGz98Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2012 at 12:06 PM, Felipe Balbi <balbi@ti.com> wrote:

[...]
>> +      * Don't write to this register if the IE state is 0 as it can
>> +      * cause deadlock.
>> +      */
>> +     if (dev->iestate)
>> +             omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
>> +}
>> +
>>  static int omap_i2c_init(struct omap_i2c_dev *dev)
>>  {
>> -     u16 psc = 0, scll = 0, sclh = 0, buf = 0;
>> +     u16 psc = 0, scll = 0, sclh = 0;
>>       u16 fsscll = 0, fssclh = 0, hsscll = 0, hssclh = 0;
>>       unsigned long fclk_rate = 12000000;
>>       unsigned long timeout;
>> @@ -337,11 +358,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>>                        * REVISIT: Some wkup sources might not be needed.
>>                        */
>>                       dev->westate = OMAP_I2C_WE_ALL;
>> -                     omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
>> -                                                     dev->westate);
>
> remove the comment too since now that's done by some other function ?

The comment is applicable to the OMAP_I2C_WE_ALL value.
So I thought it could be kept.

dont feel strongly though.


>
>>               }
