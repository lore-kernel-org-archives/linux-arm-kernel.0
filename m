From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 10 Aug 2017 09:09:19 +0900
Subject: [PATCH v2 4/5] usb: gadget: udc: Replace the deprecated extcon API
In-Reply-To: <5987CB59.9070008@samsung.com>
References: <1501748448-26821-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170803082050epcas1p2491eedf2f26510f55cd15ce777356fce@epcas1p2.samsung.com>
 <1501748448-26821-5-git-send-email-cw00.choi@samsung.com>
 <5987CB59.9070008@samsung.com>
Message-ID: <598BA42F.8060808@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping.

Hi Felipe,

I sent the first patch[1] more than three weeks ago.
But I didn't receive the any review.
[1] https://lkml.org/lkml/2017/7/16/523

This patch is very simple. After finishing the review
I'll remove the deprecated extcon API and then send
the immutable branch to both phy and usb maintainer.


Usually, I send the extcon's pull request to the GregKH
for the next merge after releasing 4.x-rc6.
(4.x-rc4 was released)

Please review this patch.


On 2017? 08? 07? 11:07, Chanwoo Choi wrote:
> Dear Felipe,
> 
> Could you please review this patch?
> I hope to remove the deprecated extcon API.
> 
> Regards,
> Chanwoo Choi
> 
> On 2017? 08? 03? 17:20, Chanwoo Choi wrote:
>> This patch replaces the deprecated extcon API as following:
>> - extcon_get_cable_state_() -> extcon_get_state()
>>
>> Cc: Felipe Balbi <balbi@kernel.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Raviteja Garimella <raviteja.garimella@broadcom.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/usb/gadget/udc/snps_udc_plat.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/udc/snps_udc_plat.c b/drivers/usb/gadget/udc/snps_udc_plat.c
>> index 2e11f19e07ae..0ce7b3ba60ff 100644
>> --- a/drivers/usb/gadget/udc/snps_udc_plat.c
>> +++ b/drivers/usb/gadget/udc/snps_udc_plat.c
>> @@ -184,7 +184,7 @@ static int udc_plat_probe(struct platform_device *pdev)
>>  			goto exit_phy;
>>  		}
>>  
>> -		ret = extcon_get_cable_state_(udc->edev, EXTCON_USB);
>> +		ret = extcon_get_state(udc->edev, EXTCON_USB);
>>  		if (ret < 0) {
>>  			dev_err(dev, "Can't get cable state\n");
>>  			goto exit_extcon;
>> @@ -273,7 +273,7 @@ static int udc_plat_suspend(struct device *dev)
>>  	udc = dev_get_drvdata(dev);
>>  	stop_udc(udc);
>>  
>> -	if (extcon_get_cable_state_(udc->edev, EXTCON_USB) > 0) {
>> +	if (extcon_get_state(udc->edev, EXTCON_USB) > 0) {
>>  		dev_dbg(udc->dev, "device -> idle\n");
>>  		stop_udc(udc);
>>  	}
>> @@ -303,7 +303,7 @@ static int udc_plat_resume(struct device *dev)
>>  		return ret;
>>  	}
>>  
>> -	if (extcon_get_cable_state_(udc->edev, EXTCON_USB) > 0) {
>> +	if (extcon_get_state(udc->edev, EXTCON_USB) > 0) {
>>  		dev_dbg(udc->dev, "idle -> device\n");
>>  		start_udc(udc);
>>  	}
>>
> 
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
