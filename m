From: paul.liu@linaro.org (Ying-Chun Liu (PaulLiu))
Date: Fri, 02 Mar 2012 15:51:55 +0800
Subject: [PATCH v6 1/2] mfd: Add anatop mfd driver
In-Reply-To: <D958900912E20642BCBC71664EFECE3E6DD2912252@BGMAIL02.nvidia.com>
References: <1330593052-15184-1-git-send-email-paul.liu@linaro.org>
 <1330671641-6439-1-git-send-email-paul.liu@linaro.org>
 <D958900912E20642BCBC71664EFECE3E6DD2912252@BGMAIL02.nvidia.com>
Message-ID: <4F507C1B.1050909@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2012?03?02? 15:07), Venu Byravarasu wrote:
> Why you did not made use of regmap?
> 

Hi Venu,

I cannot fully understand. Anatop is not SPI or I2C device. It is
internally embedded into the SoC. It is directly accessed by memory I/O.

Do you mean I should implement a regmap_bus which uses memory I/O and
then use regmap?

Regards,
Paul

>> -----Original Message-----
>> From: linux-kernel-owner at vger.kernel.org [mailto:linux-kernel-
>> owner at vger.kernel.org] On Behalf Of Ying-Chun Liu (PaulLiu)
>> Sent: Friday, March 02, 2012 12:31 PM
>> To: linux-arm-kernel at lists.infradead.org
>> Cc: linux-kernel at vger.kernel.org; linaro-dev at lists.linaro.org;
>> patches at linaro.org; Ying-Chun Liu (PaulLiu); Samuel Ortiz; Mark Brown; Shawn
>> Guo
>> Subject: [PATCH v6 1/2] mfd: Add anatop mfd driver
>>
>> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
>>
>> Anatop is a mfd chip embedded in Freescale i.MX6Q SoC.
>> Anatop provides regulators and thermal.
>> This driver handles the address space and the operation of the mfd device.
>>
>> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
>> Cc: Samuel Ortiz <sameo@linux.intel.com>
>> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>> ---
>>  drivers/mfd/Kconfig        |    6 ++
