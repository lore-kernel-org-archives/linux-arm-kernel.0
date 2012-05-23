From: jonghwa3.lee@samsung.com (jonghwa3.lee at samsung.com)
Date: Wed, 23 May 2012 13:40:13 +0900
Subject: [PATCH v3 2/2] regulator: Add support for MAX77686.
In-Reply-To: <CAKew6eW2eGrBnzSGsr3N_dXSixXv-bkBo7xkbC-o9DNnwBhcuw@mail.gmail.com>
References: <y@samsung.com> <4fbb2ada.63de440a.589d.78e2@mx.google.com>
 <4FBC3FF0.5080408@samsung.com>
 <CAKew6eW2eGrBnzSGsr3N_dXSixXv-bkBo7xkbC-o9DNnwBhcuw@mail.gmail.com>
Message-ID: <4FBC6A2D.6040408@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012? 05? 23? 13:16, Yadwinder Singh Brar wrote:

>>> +     max77686_update_reg(i2c, MAX77686_REG_BUCK2CTRL1,
>>> +             max77686->ramp_delay << 6, RAMP_MASK);
>>> +     max77686_update_reg(i2c, MAX77686_REG_BUCK3CTRL1,
>>> +             max77686->ramp_delay << 6, RAMP_MASK);
>>> +     max77686_update_reg(i2c, MAX77686_REG_BUCK4CTRL1,
>>> +             max77686->ramp_delay << 6, RAMP_MASK);
>>> +
>>
>>
>> Why do you use i2c client still? If you registered regmap you can use
>> its API. I recommend you to use regmap_update_bits() directly.
>>
>>
> 
> Yes, we are using regmap_update_bits().  max77686_update_reg() is just
> a wrapper over it.
> 


Yes, i know what you mean. However it doesn't need max77686_update_reg()
any more since it uses regmap API. Why don't you just pass iodev->regmap
to regmap_update_bits(). It is clear that there is no reason for using
i2c client as a medium. Please check regulator and mfd driver of my
previous patch.


Thanks.
