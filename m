From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Tue, 05 Aug 2014 17:14:26 +0530
Subject: [PATCH RESEND] usb: ehci/ohci-exynos: Fix PHY getting sequence
In-Reply-To: <000d01cfb09c$239a8670$6acf9350$%han@samsung.com>
References: <1407235148-31790-1-git-send-email-gautam.vivek@samsung.com>
 <000d01cfb09c$239a8670$6acf9350$%han@samsung.com>
Message-ID: <4F887641414547418FB42327CF5E09DF@sisodomain.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jingoo,


On Tuesday, August 05, 2014 4:28 PM, Jingoo Han wrote:
> On Tuesday, August 05, 2014 7:39 PM, Vivek Gautam wrote:
>>
>> Since we want to keep support for both older usb-phys as well as the
>> newer generic phys, lets first get the generic PHYs and fallback to
>> older USB-PHYs only when we fail to get the former.
>> This should fix the issue with ehci-exynos and ohci-exynos, wherein
>> in the absence of SAMSUNG_USB2PHY config symbol, we end up getting
>> the NOP_USB_XCEIV phy when the same is enabled. And thus the PHYs
>> are not configured properly.
>>
>> Reported-by: Sachin Kamat <sachin.kamat@samsung.com>
>> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
>> Cc: Alan Stern <stern@rowland.harvard.edu>
>> Cc: Jingoo Han <jg1.han@samsung.com>
>
> Acked-by: Jingoo Han <jg1.han@samsung.com>
>
> Right, we would get the generic PHYs first, then get the older
> usb-phys. Then, the older one will be removed from the kernel.

Right, I have a set of patches to remove the older phy support for Exynos 
SoC series,
keeping the support for S3C64XX, which I shall send soon.

[snip]

Thanks
Vivek Gautam 
