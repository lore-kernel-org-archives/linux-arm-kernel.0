From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 09 May 2014 09:34:14 +0200
Subject: [PATCH v2 3/7] mfd: add support for sun6i PRCM (Power/Reset/Clock
 Management) unit
In-Reply-To: <20140509071246.GE5767@lee--X1>
References: <1399483554-8824-1-git-send-email-boris.brezillon@free-electrons.com>
 <1399483554-8824-4-git-send-email-boris.brezillon@free-electrons.com>
 <20140508110205.GB5767@lee--X1> <536BE366.8080907@free-electrons.com>
 <20140509071246.GE5767@lee--X1>
Message-ID: <536C84F6.2050701@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 05/09/2014 09:12 AM, Lee Jones wrote:
>>>> +static struct platform_driver sun6i_prcm_driver = {
>>>> +	.driver = {
>>>> +		.name = "sun6i-prcm",
>>>> +		.owner = THIS_MODULE,
>>>> +		.of_match_table = sun6i_prcm_dt_ids,
>>>> +	},
>>>> +	.probe = sun6i_prcm_probe,
>>> You need a .remove() call-back.
>>
>> This driver cannot be compiled as module (see the Kconfig definition)
>> and the devices are not hotpluggable, as a result a probed device will
>> never be removed.
>>
>> Do you still want me to implement the remove function ?
> 
> .remove() also be run on shut down.

That is not true, if your device needs to do anything special at shutdown
you need to add a shutdown callback. Devices are kept as is (not torn down)
on shutdown.

> It's best practice to have one.
> 
>>>> +module_platform_driver(sun6i_prcm_driver);
>>>> +
>>>> +MODULE_AUTHOR("Boris BREZILLON <boris.brezillon@free-electrons.com>");
>>>> +MODULE_DESCRIPTION("Allwinner sun6i PRCM driver");
>>>> +MODULE_LICENSE("GPL v2");
>>
> 

Regards,

Hans
