From: hugues.fruchet@st.com (Hugues FRUCHET)
Date: Tue, 9 May 2017 07:36:34 +0000
Subject: [PATCH v5 2/8] [media] stm32-dcmi: STM32 DCMI camera interface
 driver
In-Reply-To: <dd4a1ec1-b84a-81cb-51b6-c2e53b5efcc5@xs4all.nl>
References: <1493998287-5828-1-git-send-email-hugues.fruchet@st.com>
 <1493998287-5828-3-git-send-email-hugues.fruchet@st.com>
 <dd4a1ec1-b84a-81cb-51b6-c2e53b5efcc5@xs4all.nl>
Message-ID: <5d588e10-4185-60c5-de38-54b2a4428ae6@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,
It's OK, feel free to change.
BR
Hugues.


On 05/06/2017 10:54 AM, Hans Verkuil wrote:
> Hi Hugues,
>
> On 05/05/2017 05:31 PM, Hugues Fruchet wrote:
>> This V4L2 subdev driver enables Digital Camera Memory Interface (DCMI)
>> of STMicroelectronics STM32 SoC series.
>>
>> Reviewed-by: Hans Verkuil <hans.verkuil@cisco.com>
>> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
>> Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
>> ---
>>  drivers/media/platform/Kconfig            |   12 +
>>  drivers/media/platform/Makefile           |    2 +
>>  drivers/media/platform/stm32/Makefile     |    1 +
>>  drivers/media/platform/stm32/stm32-dcmi.c | 1403 +++++++++++++++++++++++++++++
>>  4 files changed, 1418 insertions(+)
>>  create mode 100644 drivers/media/platform/stm32/Makefile
>>  create mode 100644 drivers/media/platform/stm32/stm32-dcmi.c
>>
>> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
>> index ac026ee..de6e18b 100644
>> --- a/drivers/media/platform/Kconfig
>> +++ b/drivers/media/platform/Kconfig
>> @@ -114,6 +114,18 @@ config VIDEO_S3C_CAMIF
>>  	  To compile this driver as a module, choose M here: the module
>>  	  will be called s3c-camif.
>>
>> +config VIDEO_STM32_DCMI
>> +	tristate "Digital Camera Memory Interface (DCMI) support"
>
> Is it OK with you if I change this to:
>
> 	tristate "STM32 Digital Camera Memory Interface (DCMI) support"
>
> Right now the text gives no indication that this driver is for an STM32 platform.
>
> No need to spin a new patch, just let me know you're OK with it and I'll make
> the change.
>
> Regards,
>
> 	Hans
>
>> +	depends on VIDEO_V4L2 && OF && HAS_DMA
>> +	depends on ARCH_STM32 || COMPILE_TEST
>> +	select VIDEOBUF2_DMA_CONTIG
>> +	---help---
>> +	  This module makes the STM32 Digital Camera Memory Interface (DCMI)
>> +	  available as a v4l2 device.
>> +
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called stm32-dcmi.
>> +
>>  source "drivers/media/platform/soc_camera/Kconfig"
>>  source "drivers/media/platform/exynos4-is/Kconfig"
>>  source "drivers/media/platform/am437x/Kconfig"
