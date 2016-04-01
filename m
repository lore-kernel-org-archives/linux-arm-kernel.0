From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 1 Apr 2016 22:45:47 +0300
Subject: [PATCH v2 06/11] phy: da8xx-usb: new driver for DA8XX SoC USB PHY
In-Reply-To: <56FE9B8F.7050605@lechnology.com>
References: <1458181615-27782-1-git-send-email-david@lechnology.com>
 <1458181615-27782-7-git-send-email-david@lechnology.com>
 <56FE74AC.6080303@ti.com> <20160401144510.GA6264@uda0271908>
 <56FE9B8F.7050605@lechnology.com>
Message-ID: <56FECFEB.2030708@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/01/2016 07:02 PM, David Lechner wrote:

>>>> +EXPORT_SYMBOL_GPL(da8xx_usb20_phy_set_mode);
>>>
>>> Don't prefer export symbols from PHY driver. That'll create unnecessary
>>> dependencies between the controller and the PHY.
>>
>> Agreed.
>>
>>> I think it'll be better to create a new attribute and use it?
>>
>> Another simpler option is to not support _set_mode() for DA8xx, and the
>> phy driver set the otgmode bit in probe() based on dr_mode of the
>> controller.
>>
>> Regards,
>> -Bin.
>
> This certainly works for my particular use case, however, Sergei Shtylyov, who
> wrote the da8xx musb glue layer originally, seemed to recall in his review of
> the patch series that this really is necessary for OTG mode to work properly.

    No, it's still not necessary, however this method is now called from 
musb_init_controller() (it wasn't in my time). ISTR however that you needed to 
enforce the mode override in CFGCHIP2 for the host mode to function properly.

WBR, Sergei
