From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 25 Jun 2016 09:09:31 +0800
Subject: [linux-sunxi] Re: [PATCH 01/14] ARM: dts: sun8i: Add SID node
In-Reply-To: <416577ad-f8d0-d12a-a092-9b22ad2f31f1@megous.com>
References: <20160623192104.18720-1-megous@megous.com>
 <20160623192104.18720-2-megous@megous.com>
 <CAGb2v677+abNOEg3iEoiH25Ji9tq0JXkrGUVvLPAbXAPD3Su_g@mail.gmail.com>
 <416577ad-f8d0-d12a-a092-9b22ad2f31f1@megous.com>
Message-ID: <CAGb2v65MD1EMs5MNahMDnkt4-EQjUGSTxTXkGZz1i9xaEXs+Gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jun 25, 2016 at 3:58 AM, Ond?ej Jirman <megous@megous.com> wrote:
> Hello,
>
> thank you for the review.
>
> On 24.6.2016 04:41, Chen-Yu Tsai wrote:
>> On Fri, Jun 24, 2016 at 3:20 AM,  <megous@megous.com> wrote:
>>> From: Josef Gajdusek <atx@atx.name>
>>>
>>> Add a node describing the Security ID memory to the Allwinner H3 .dtsi file.
>>>
>>> Signed-off-by: Josef Gajdusek <atx@atx.name>
>>> ---
>>>  arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
>>> index 4a4926b..172576d 100644
>>> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
>>> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
>>> @@ -389,6 +389,13 @@
>>>                         #size-cells = <0>;
>>>                 };
>>>
>>> +               sid: eeprom at 01c14000 {
>>> +                       compatible = "allwinner,sun4i-a10-sid";
>>
>> This has been discussed before. The hardware is not compatible.
>> The write control registers are at different offsets.
>
> I'm not sure what you mean by write control registers. Code in
> sunxi_sid.c implements only read access to the nvram. Can you pelase
> elaborate?

See http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/388022.html

Also, different compatibles are used for different hardware, regardless
of how close the drivers may be. The driver might only be compatible when
implementing a subset of the possible features. If one were to fully
implement it, they would become incompatible.

To put it another way, the compatible string designates the hardware,
and the driver implements support for that compatible string.

ChenYu

>   Ondrej
>
>>
>> ChenYu
>>
>>> +                       reg = <0x01c14000 0x400>;
>>> +                       #address-cells = <1>;
>>> +                       #size-cells = <1>;
>>> +               };
>>> +
>>>                 usbphy: phy at 01c19400 {
>>>                         compatible = "allwinner,sun8i-h3-usb-phy";
>>>                         reg = <0x01c19400 0x2c>,
>>> --
>>> 2.9.0
>>>
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
