From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 May 2012 08:46:35 +0100
Subject: [PATCH 09/16] ARM: ux500: Provide regulator support for SMSC911x
 via Device Tree
In-Reply-To: <CACRpkdZKDEcntKqTzowCZku+Nwm3Js53Z71iPRWCnY5kXVi0Dg@mail.gmail.com>
References: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
 <1337330355-17747-10-git-send-email-lee.jones@linaro.org>
 <CACRpkdZKDEcntKqTzowCZku+Nwm3Js53Z71iPRWCnY5kXVi0Dg@mail.gmail.com>
Message-ID: <4FBB445B.5010900@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/05/12 22:42, Linus Walleij wrote:
> On Fri, May 18, 2012 at 10:39 AM, Lee Jones<lee.jones@linaro.org>  wrote:
>
>> This patch adds a fixed regulator for use by the SMSC911x Ethernet
>> chip driver into the db8500 Device Tree. It also references other
>> regulators required by the same device.
>>
>> Signed-off-by: Lee Jones<lee.jones@linaro.org>
>>   arch/arm/boot/dts/snowball.dts   |   13 +++++++++++++
>>   arch/arm/configs/u8500_defconfig |    1 +
>>   drivers/mfd/db8500-prcmu.c       |    1 +
>
> We usually don't mix code and defconfig changes in the same patch.
>
> Why can't the snowball Kconfig select the fixed regulator instead,
> so you get rid of the defconfig change?

I can do that.

>> diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
>> index d534449..40204e1 100644
>> --- a/drivers/mfd/db8500-prcmu.c
>> +++ b/drivers/mfd/db8500-prcmu.c
>> @@ -2735,6 +2735,7 @@ static struct regulator_consumer_supply db8500_vape_consumers[] = {
>>         REGULATOR_SUPPLY("vcore", "uart2"),
>>         REGULATOR_SUPPLY("v-ape", "nmk-ske-keypad.0"),
>>         REGULATOR_SUPPLY("v-hsi", "ste_hsi.0"),
>> +       REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
>>   };
>
> Hm we have discussed previously that these regulator supplies should be passed
> from the platform rather than open-coded in the driver.

So, do you want me to chop this out of this patch and re-submit then?

> Well, Device Tree solves that problem long term I guess.

Right.


-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
