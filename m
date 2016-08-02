From: Songjun.Wu@microchip.com (Wu, Songjun)
Date: Tue, 2 Aug 2016 15:48:25 +0800
Subject: [PATCH v7 1/2] [media] atmel-isc: add the Image Sensor Controller
 code
In-Reply-To: <cdb406b8-bb1e-9a78-e07c-f5df3dbcfe34@xs4all.nl>
References: <1469778856-24253-1-git-send-email-songjun.wu@microchip.com>
 <1469778856-24253-2-git-send-email-songjun.wu@microchip.com>
 <f77652aa-3d41-d85f-11a9-9f5290223834@xs4all.nl>
 <b32b2346-cc11-521e-c2f8-6d9e951c7a16@microchip.com>
 <cdb406b8-bb1e-9a78-e07c-f5df3dbcfe34@xs4all.nl>
Message-ID: <300f7f9a-d3dd-1430-3edd-9ca682038ca8@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 8/2/2016 15:32, Hans Verkuil wrote:
>
>
> On 08/02/2016 08:20 AM, Wu, Songjun wrote:
>>>> +static unsigned int sensor_preferred = 1;
>>>> +module_param(sensor_preferred, uint, S_IRUGO|S_IWUSR);
>>>> +MODULE_PARM_DESC(sensor_preferred,
>>>> +		 "Sensor is preferred to output the specified format (1-on 0-off) default 1");
>>>
>>> I have no idea what this means. Can you elaborate? Why would you want to set this to 0?
>>>
>> ISC can convert the raw format to the other format, e.g. YUYV.
>> If we want to output YUYV format, there are two choices, one is the
>> sensor output YUYV format, ISC bypass the data to the memory, the other
>> is the sensor output raw format, ISC convert raw format to YUYV.
>>
>> So I provide a module parameter to user to select.
>> I prefer to select the sensor to output the specified format, then I set
>> this parameter to '1', not '0'.
>
> Does this only apply to YUYV?
>
> The reason I am hesitant about this option is that I am not convinced you need
> it. The default (sensor preferred) makes sense and that's what other drivers
> do as well. Unless you know of a real use-case where you want to set this to 0,
> I would just drop this option.
>
> If there *is* a real use-case, then split off adding this module option into a
> separate patch so we can discuss it more without blocking getting this driver
> into mainline. I don't like the way this is done here.
>
This does not only apply to YUYV, ISC IP defines some formats that can 
be converted from raw format.
In some scenarios, ISC can extend the formats, e.g. if the sensor does 
not support YUYV, but raw format, the ISC can output YUYV.

OK, I will remove the related code.
After this driver is accepted, I will submit another patch to add this 
feature.

Thank you.

> Regards,
>
> 	Hans
>
