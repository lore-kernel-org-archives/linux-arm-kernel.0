From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 13 Jun 2015 15:30:50 +0200
Subject: [PATCH 00/20] ARM: dts: Add USB and OTG related nodes and enable
 on various boards
In-Reply-To: <557ADE40.70200@redhat.com>
References: <1433530943-12599-1-git-send-email-hdegoede@redhat.com>
 <20150608100358.GW23777@lukather> <55783B2C.3080207@redhat.com>
 <557ADE40.70200@redhat.com>
Message-ID: <557C308A.4010104@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 12-06-15 15:27, Hans de Goede wrote:
> Hi,
>
> On 10-06-15 15:27, Hans de Goede wrote:
>> Hi,
>>
>> On 08-06-15 12:03, Maxime Ripard wrote:
>>> Hi Hans,
>>>
>>> On Fri, Jun 05, 2015 at 09:02:03PM +0200, Hans de Goede wrote:
>>>> Hi Maxime,
>>>>
>>>> Here is a patch-set with all the otg / sun8i-usb-host related dts patches
>>>> I've accumulated.
>>>>
>>>> These are intended for 4.3, and go hand in hand with the outstanding
>>>> musb-sunxi / phy-sun4i-usb patches, which I expect to be merged as is
>>>> for 4.3 .
>>>
>>> I'm fine with these patches. Do you have a branch somewhere that I can
>>> pull (without the one that you wanted me to drop, obviously)?
>>
>> I've just created a branch with just these patches directly on top
>> of sunxi/for-next for you:
>>
>> https://github.com/jwrdegoede/linux-sunxi/commits/otg-dts-for-maxime
>
> Please ignore this for now. There have been some changes to the extcon
> framework, making it more integrated with devicetree, this means I need
> to add an extcon property to the musb nodes in devicetree:
>
> --- a/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.txt
> +++ b/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.txt
> @@ -12,6 +12,7 @@ Required properties:
>    - phys            : phy specifier for the otg phy
>    - phy-names       : must be "usb"
>    - dr_mode         : Dual-Role mode must be "host" or "otg"
> + - extcon          : extcon specifier for the otg phy
>
>   Example:
>
> @@ -23,5 +24,6 @@ Example:
>                  interrupt-names = "mc";
>                  phys = <&usbphy 0>;
>                  phy-names = "usb";
> +         extcon = <&usbphy 0>;
>                  status = "disabled";
>          };
>
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -773,6 +773,7 @@
>                          interrupt-names = "mc";
>                          phys = <&usbphy 0>;
>                          phy-names = "usb";
> +                 extcon = <&usbphy 0>;
>                          allwinner,sram = <&otg_sram 1>;
>                          status = "disabled";
>                  };
>
> I'll push a new version of the patches to otg-dts-for-maxime
> with the extcon property added for you and ping you when it is
> ready.

Done, https://github.com/jwrdegoede/linux-sunxi/commits/otg-dts-for-maxime
now contains the necessary changes and is ready for merging for 4.3.

Regards,

Hans
