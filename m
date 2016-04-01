From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 1 Apr 2016 22:49:25 +0300
Subject: [PATCH v2 06/11] phy: da8xx-usb: new driver for DA8XX SoC USB PHY
In-Reply-To: <20160401161931.GC6264@uda0271908>
References: <1458181615-27782-1-git-send-email-david@lechnology.com>
 <1458181615-27782-7-git-send-email-david@lechnology.com>
 <56FE74AC.6080303@ti.com> <20160401144510.GA6264@uda0271908>
 <56FE9B8F.7050605@lechnology.com> <20160401161931.GC6264@uda0271908>
Message-ID: <56FED0C5.1000603@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/01/2016 07:19 PM, Bin Liu wrote:

>>>>> +EXPORT_SYMBOL_GPL(da8xx_usb20_phy_set_mode);
>>>>
>>>> Don't prefer export symbols from PHY driver. That'll create unnecessary
>>>> dependencies between the controller and the PHY.
>>>
>>> Agreed.
>>>
>>>>
>>>> I think it'll be better to create a new attribute and use it?
>>>
>>> Another simpler option is to not support _set_mode() for DA8xx, and the
>>> phy driver set the otgmode bit in probe() based on dr_mode of the
>>> controller.
>>>
>>> Regards,
>>> -Bin.
>>>
>>
>> This certainly works for my particular use case, however, Sergei
>> Shtylyov, who wrote the da8xx musb glue layer originally, seemed to
>> recall in his review of the patch series that this really is
>> necessary for OTG mode to work properly.
>
> I don't know much about the usb module on DA8xx, but it seems to me that
> _set_mode() has nothing to do with OTG mode.

    No, it does.

> musb_core only calls
> _set_mode() in two places - 1) sysfs: musb_mode_store(), 2) init:
> musb_init_controller(). None of them should be related to OTG mode.

    Both these places do select OTG mode.

> Regards,
> -Bin.

MBR, Sergei
