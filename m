From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 31 Jul 2015 16:24:31 +0200
Subject: [linux-sunxi] [PATCH v5 2/7] phy-sun4i-usb: Add extcon support
 for the otg phy (phy0)
In-Reply-To: <55BB84D7.70109@gmail.com>
References: <1434199071-22127-1-git-send-email-hdegoede@redhat.com>
 <1434199071-22127-3-git-send-email-hdegoede@redhat.com>
 <55BB84D7.70109@gmail.com>
Message-ID: <55BB851F.4090602@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 31-07-15 16:23, Jonathan Liu wrote:
> Hi Hans,
>
> On 13/06/2015 10:37 PM, Hans de Goede wrote:
>> The sunxi musb glue needs to know if a host or normal usb cable is plugged
>> in, add extcon support so that the musb glue can monitor the host status.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v5:
>> -Split out of the "Add id and vbus detection support" commit
>> -Ported to the new extcon API queued for 4.2
>> ---
>>   drivers/phy/Kconfig         |  1 +
>>   drivers/phy/phy-sun4i-usb.c | 32 +++++++++++++++++++++++++++++++-
>>   2 files changed, 32 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
>> index a53bd5b..9841780 100644
>> --- a/drivers/phy/Kconfig
>> +++ b/drivers/phy/Kconfig
>> @@ -173,6 +173,7 @@ config PHY_SUN4I_USB
>>       tristate "Allwinner sunxi SoC USB PHY driver"
>>       depends on ARCH_SUNXI && HAS_IOMEM && OF
>>       depends on RESET_CONTROLLER
>> +    depends on EXTCON
>>       select GENERIC_PHY
>>       help
>>         Enable this to support the transceiver that is part of Allwinner
>>
> Should probably add CONFIG_EXTCON=y to arch/arm/configs/sunxi_defconfig so that CONFIG_PHY_SUN4I_USB=y works out of the box.

Right, ChenYu just send out 2 defconfig patches fixing this.

Thanks for the heads up.

Regards,

Hans
