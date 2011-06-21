From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 21 Jun 2011 16:00:38 +0400
Subject: [RFC][PATCH 2/5] ARM: SAMSUNG: Changing the build condition of
	OTG platform device for samsung.
In-Reply-To: <20110621114940.GB2531@legolas.emea.dhcp.ti.com>
References: <1308639827-2121-1-git-send-email-p.paneri@samsung.com>
	<1308639827-2121-3-git-send-email-p.paneri@samsung.com>
	<4E0084B8.1040201@ru.mvista.com>
	<20110621114940.GB2531@legolas.emea.dhcp.ti.com>
Message-ID: <4E0087E6.6020405@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 21-06-2011 15:49, Felipe Balbi wrote:

>>> From: Praveen Paneri<p.paneri@samsung.com>

>>> Adding dwc driver name in existing platform device
>>> to probe DWC OTG driver.
>>> Introduced otg_set_platdata function to pass platform data
>>> Added selectable config option to add DWC OTG driver for different
>>> machines.

>>> Signed-off-by: Praveen Paneri<p.paneri@samsung.com>
>> [...]

>>> diff --git a/arch/arm/plat-samsung/dev-usb-hsotg.c b/arch/arm/plat-samsung/dev-usb-hsotg.c
>>> index 33a844a..7e6228b 100644
>>> --- a/arch/arm/plat-samsung/dev-usb-hsotg.c
>>> +++ b/arch/arm/plat-samsung/dev-usb-hsotg.c
>> [...]

>>> @@ -37,7 +39,12 @@ static struct resource s3c_usb_hsotg_resources[] = {
>>>   static u64 s3c_hsotg_dmamask = DMA_BIT_MASK(32);
>>>
>>>   struct platform_device s3c_device_usb_hsotg = {
>>> +#ifdef CONFIG_S3C_DEV_USB_HSOTG
>>>   	.name		= "s3c-hsotg",
>>> +#endif
>>> +#ifdef CONFIG_S3C_DEV_DWC_OTG
>>> +	.name		= "dwc_otg",
>>> +#endif

>>     I'd done it as:

>> +#if defined(CONFIG_S3C_DEV_USB_HSOTG)
>>    	.name		= "s3c-hsotg",
>> +#elif defined(CONFIG_S3C_DEV_DWC_OTG)
>> +	.name		= "dwc_otg",
>> +#endif

> no... don't do that. How many times do I have to repeat ? No ifdefs!! we
> want both drivers to be able to be compiled as modules, so add both
> platform devices.

    Sorry, hadn't seen your mail when replying.

WBR, Sergei
