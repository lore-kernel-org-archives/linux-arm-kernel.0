From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 9 Nov 2015 23:44:42 -0500
Subject: [PATCH V3 4/4] dma: add Qualcomm Technologies HIDMA channel driver
In-Reply-To: <20151109181924.GA5205@rob-hp-laptop>
References: <1446958380-23298-1-git-send-email-okaya@codeaurora.org>
 <1446958380-23298-5-git-send-email-okaya@codeaurora.org>
 <20151109181924.GA5205@rob-hp-laptop>
Message-ID: <5641763A.1060505@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/9/2015 1:19 PM, Rob Herring wrote:
> On Sat, Nov 07, 2015 at 11:53:00PM -0500, Sinan Kaya wrote:
>> This patch adds support for hidma engine. The driver
>> consists of two logical blocks. The DMA engine interface
>> and the low-level interface. The hardware only supports
>> memcpy/memset and this driver only support memcpy
>> interface. HW and driver doesn't support slave interface.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>   .../devicetree/bindings/dma/qcom_hidma.txt         |  18 +
>>   drivers/dma/qcom/Kconfig                           |   9 +
>>   drivers/dma/qcom/Makefile                          |   2 +
>>   drivers/dma/qcom/hidma.c                           | 743 ++++++++++++++++
>>   drivers/dma/qcom/hidma.h                           | 157 ++++
>>   drivers/dma/qcom/hidma_dbg.c                       | 225 +++++
>>   drivers/dma/qcom/hidma_ll.c                        | 944 +++++++++++++++++++++
>>   7 files changed, 2098 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/dma/qcom_hidma.txt
>>   create mode 100644 drivers/dma/qcom/hidma.c
>>   create mode 100644 drivers/dma/qcom/hidma.h
>>   create mode 100644 drivers/dma/qcom/hidma_dbg.c
>>   create mode 100644 drivers/dma/qcom/hidma_ll.c
>>
>> diff --git a/Documentation/devicetree/bindings/dma/qcom_hidma.txt b/Documentation/devicetree/bindings/dma/qcom_hidma.txt
>> new file mode 100644
>> index 0000000..c9fb2d44
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/qcom_hidma.txt
>> @@ -0,0 +1,18 @@
>> +Qualcomm Technologies HIDMA Channel driver
>> +
>> +Required properties:
>> +- compatible: must contain "qcom,hidma"
>
> This should be "qcom,hidma-1.0" to match the example and driver. I
> would drop "qcom,hidma" altogether.

I matched it.

>
> Rob
>

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
