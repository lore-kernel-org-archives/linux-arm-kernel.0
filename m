From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 4 Apr 2016 16:41:22 +0300
Subject: [PATCH] usb: dwc3: keystone: drop dma_mask configuration
In-Reply-To: <87pou561i5.fsf@intel.com>
References: <1459769611-16862-1-git-send-email-grygorii.strashko@ti.com>
 <87pou561i5.fsf@intel.com>
Message-ID: <57026F02.4060300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2016 02:45 PM, Felipe Balbi wrote:
>
> Hi,
>
> Grygorii Strashko <grygorii.strashko@ti.com> writes:
>> The Keystone 2 supports DT-boot only, as result dma_mask will be
>> always configured properly from DT -
>> of_platform_device_create_pdata()->of_dma_configure(). More over,
>> dwc3-keystone.c can be built as module and in this case it's unsafe to
>> assign local variable as dma_mask.
>>
>> Hence, remove dma_mask configuration code.
>>
>> Cc: Murali Karicheri <m-karicheri2@ti.com>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>
> with these two patches from you, does USB Peripheral work on k2 devices ?

I've tried CONFIG_USB_DWC3_GADGET=y + g_zero and k2e was detected
as gzero dev from Host PC

>
> I'll drop my k2 changes from my series which I sent on saturday.
>

Yes, please.

-- 
regards,
-grygorii
