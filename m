From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 10 Mar 2015 10:10:24 +0100
Subject: [linux-sunxi] [PATCH 09/15] ARM: dts: sun4i: Add USB Dual Role
 Controller
In-Reply-To: <CAGRGNgVsf05rtLC2+yOPrbrPV-ceQzPC=ZX1zX+hfNxdC7OX-A@mail.gmail.com>
References: <1425933628-9672-1-git-send-email-hdegoede@redhat.com>
 <1425933628-9672-10-git-send-email-hdegoede@redhat.com>
 <CAGRGNgVsf05rtLC2+yOPrbrPV-ceQzPC=ZX1zX+hfNxdC7OX-A@mail.gmail.com>
Message-ID: <54FEB500.8050409@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10-03-15 00:31, Julian Calaby wrote:
> Hi Hans,
>
> On Tue, Mar 10, 2015 at 7:40 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Add a node for the otg/drc usb controller to sun4i-a10.dtsi.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   arch/arm/boot/dts/sun4i-a10.dtsi | 12 ++++++++++++
>>   drivers/usb/musb/Kconfig         |  1 +
>>   2 files changed, 13 insertions(+)
>>
>> diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
>> index 8180a3a..fab8e9a 100644
>> --- a/drivers/usb/musb/Kconfig
>> +++ b/drivers/usb/musb/Kconfig
>> @@ -65,6 +65,7 @@ comment "Platform Glue Layer"
>>   config USB_MUSB_SUNXI
>>          tristate "Allwinner (sunxi)"
>>          depends on ARCH_SUNXI
>> +       depends on NOP_USB_XCEIV
>
> Shouldn't this be in a different patch?

Yes, this was a later fixup commit which got squashed into the wrong patch,
thanks for catching this.

This has been fixed in my personal tree, and will be in v2 of this set:
https://github.com/jwrdegoede/linux-sunxi/commits/sunxi-wip

Regards,

Hans
