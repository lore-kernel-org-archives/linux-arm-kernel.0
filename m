From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue, 10 Jan 2017 09:56:08 +0100
Subject: [PATCH v7 2/8] MFD: add STM32 Timers driver
In-Reply-To: <20170109180051.uwd4su3maj5gkf5l@rob-hp-laptop>
References: <1483608344-9012-1-git-send-email-benjamin.gaignard@st.com>
 <1483608344-9012-3-git-send-email-benjamin.gaignard@st.com>
 <20170109180051.uwd4su3maj5gkf5l@rob-hp-laptop>
Message-ID: <CA+M3ks5r71FAuy5tKeHSRtSVvDvZ21pXecYFnZEF2VrxdT81xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-01-09 19:00 GMT+01:00 Rob Herring <robh@kernel.org>:
> On Thu, Jan 05, 2017 at 10:25:38AM +0100, Benjamin Gaignard wrote:
>> This hardware block could at used at same time for PWM generation
>> and IIO timers.
>> PWM and IIO timer configuration are mixed in the same registers
>> so we need a multi fonction driver to be able to share those registers.
>>
>> version 7:
>> - rebase on v4.10-rc2
>>
>> version 6:
>> - rename files to stm32-timers
>> - rename functions to stm32_timers_xxx
>>
>> version 5:
>> - fix Lee comments about detect function
>> - add missing dependency on REGMAP_MMIO
>>
>> version 4:
>> - add a function to detect Auto Reload Register (ARR) size
>> - rename the structure shared with other drivers
>>
>> version 2:
>> - rename driver "stm32-gptimer" to be align with SoC documentation
>> - only keep one compatible
>> - use of_platform_populate() instead of devm_mfd_add_devices()
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>> ---
>>  .../devicetree/bindings/mfd/stm32-timers.txt       |  2 +-
>>  drivers/mfd/Kconfig                                | 11 +++
>>  drivers/mfd/Makefile                               |  2 +
>>  drivers/mfd/stm32-timers.c                         | 80 ++++++++++++++++++++++
>>  include/linux/mfd/stm32-timers.h                   | 71 +++++++++++++++++++
>>  5 files changed, 165 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/mfd/stm32-timers.c
>>  create mode 100644 include/linux/mfd/stm32-timers.h
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/stm32-timers.txt b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
>> index a73301d..897e7c2 100644
>> --- a/Documentation/devicetree/bindings/mfd/stm32-timers.txt
>> +++ b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
>> @@ -12,7 +12,7 @@ Required parameters:
>>
>>  - reg:                       Physical base address and length of the controller's
>>                       registers.
>> -- clock-names:               Set to "int".
>> +- clock-names:               Set to "int".
>
> This hunk should be dropped or moved to previous patch.

I will move it in the previous patch

>
>>  - clocks:            Phandle to the clock used by the timer module.
>>                       For Clk properties, please refer to ../clock/clock-bindings.txt
>>



-- 
Benjamin Gaignard

Graphic Study Group

Linaro.org ? Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
