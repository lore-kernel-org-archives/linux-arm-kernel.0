From: rogerq@ti.com (Roger Quadros)
Date: Wed, 21 Aug 2013 09:46:29 +0300
Subject: [PATCH v5 1/8] usb: phy: omap-control: Get rid of platform data
In-Reply-To: <593AEF6C47F46446852B067021A273D6D982D30B@MUCSE039.lantiq.com>
References: <1377010577-19355-1-git-send-email-rogerq@ti.com>
 <1377010577-19355-2-git-send-email-rogerq@ti.com>
 <593AEF6C47F46446852B067021A273D6D982D30B@MUCSE039.lantiq.com>
Message-ID: <52146245.6020904@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 08/20/2013 06:04 PM, thomas.langer at lantiq.com wrote:
> Hello Roger,
> 
> this will not work!
> 
> Roger Quadros wrote on 2013-08-20:
> 
>> -	struct omap_control_usb_platform_data *pdata =
>> -			dev_get_platdata(&pdev->dev);
>> +
>> +	if (np) {
>> +		of_property_read_u32(np, "ti,type", &control_usb->type);
> 
> here you are dereferencing control_usb
> 
>> +	} else {
>> +		/* We only support DT boot */
>> +		return -EINVAL;
>> +	}
>>
>>  	control_usb = devm_kzalloc(&pdev->dev, sizeof(*control_usb),
>>  		GFP_KERNEL);
> 
> and here it is allocated!

Good catch :).
The problem is eliminated by other patches in this series, so tests ran fine.
But I'll fix this one.

cheers,
-roger
