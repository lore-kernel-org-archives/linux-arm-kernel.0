From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 19 Jul 2015 12:58:52 +0200
Subject: [PATCH v6 1/4] phy-sun4i-usb: Add missing EXPORT_SYMBOL for
 sun4i_usb_phy_set_squelch_detect
In-Reply-To: <55A653AF.608@ti.com>
References: <1436366500-12555-1-git-send-email-hdegoede@redhat.com>
 <1436366500-12555-2-git-send-email-hdegoede@redhat.com> <55A653AF.608@ti.com>
Message-ID: <55AB82EC.7050309@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 15-07-15 14:35, Kishon Vijay Abraham I wrote:
> Hi,
>
> On Wednesday 08 July 2015 08:11 PM, Hans de Goede wrote:
>> sun4i_usb_phy_set_squelch_detect is used by other code, which may be built
>> as a module, so it should be exported.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v6:
>> -New patch in v6 of the sunxi musb support series
>> ---
>>   drivers/phy/phy-sun4i-usb.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
>> index e17c539..b82aa26 100644
>> --- a/drivers/phy/phy-sun4i-usb.c
>> +++ b/drivers/phy/phy-sun4i-usb.c
>> @@ -212,6 +212,7 @@ void sun4i_usb_phy_set_squelch_detect(struct phy *_phy, bool enabled)
>>
>>   	sun4i_usb_phy_write(phy, PHY_SQUELCH_DETECT, enabled ? 0 : 2, 2);
>>   }
>> +EXPORT_SYMBOL(sun4i_usb_phy_set_squelch_detect);
>
> EXPORT_SYMBOL_GPL?

Both work for me, feel free to fix this up if you prefer _GPL.

Regards,

Hans
