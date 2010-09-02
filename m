From: gbean@codeaurora.org (Gregory Bean)
Date: Thu, 02 Sep 2010 12:45:06 -0700
Subject: [PATCH 1/2 v2] msm: Install the Google-Android gpio driver.
In-Reply-To: <20100902102752.GB20737@trinity.fluff.org>
References: <1283384380-24997-1-git-send-email-gbean@codeaurora.org>
	<20100902102752.GB20737@trinity.fluff.org>
Message-ID: <4C7FFEC2.2050502@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +#define MSM_GPIO_OUT_0         MSM_GPIO1_REG(0x00)  /* gpio  15-0  */
>> +#define MSM_GPIO_OUT_1         MSM_GPIO2_REG(0x00)  /* gpio  42-16 */
>> +#define MSM_GPIO_OUT_2         MSM_GPIO1_REG(0x04)  /* gpio  67-43 */
>> +#define MSM_GPIO_OUT_3         MSM_GPIO1_REG(0x08)  /* gpio  94-68 */
>> +#define MSM_GPIO_OUT_4         MSM_GPIO1_REG(0x0C)  /* gpio 106-95 */
>> +#define MSM_GPIO_OUT_5         MSM_GPIO1_REG(0x50)  /* gpio 107-121 */
>> +
>> +/* same pin map as above, output enable */
>> +#define MSM_GPIO_OE_0          MSM_GPIO1_REG(0x10)
>> +#define MSM_GPIO_OE_1          MSM_GPIO2_REG(0x08)
>> +#define MSM_GPIO_OE_2          MSM_GPIO1_REG(0x14)
>> +#define MSM_GPIO_OE_3          MSM_GPIO1_REG(0x18)
>> +#define MSM_GPIO_OE_4          MSM_GPIO1_REG(0x1C)
>> +#define MSM_GPIO_OE_5          MSM_GPIO1_REG(0x54)
>
> do we need each and every register defined in the header? would simply
> the base of each gpio bank make this header file much smaller? or
> turn it into MSM_GPIO_OE(x) ?

Unfortunately, the registers are not regularly spaced.  There are small 
sections of regularity, but special cases abound.  I could produce 
macros or functions to calculate them, but I fear that they'd be so full 
of conditionals that the net gain would be negligible, or worse.

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
