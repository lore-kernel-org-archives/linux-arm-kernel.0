From: megous@megous.com (=?UTF-8?Q?Ond=c5=99ej_Jirman?=)
Date: Fri, 24 Jun 2016 21:58:15 +0200
Subject: [PATCH 01/14] ARM: dts: sun8i: Add SID node
In-Reply-To: <CAGb2v677+abNOEg3iEoiH25Ji9tq0JXkrGUVvLPAbXAPD3Su_g@mail.gmail.com>
References: <20160623192104.18720-1-megous@megous.com>
 <20160623192104.18720-2-megous@megous.com>
 <CAGb2v677+abNOEg3iEoiH25Ji9tq0JXkrGUVvLPAbXAPD3Su_g@mail.gmail.com>
Message-ID: <416577ad-f8d0-d12a-a092-9b22ad2f31f1@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

thank you for the review.

On 24.6.2016 04:41, Chen-Yu Tsai wrote:
> On Fri, Jun 24, 2016 at 3:20 AM,  <megous@megous.com> wrote:
>> From: Josef Gajdusek <atx@atx.name>
>>
>> Add a node describing the Security ID memory to the Allwinner H3 .dtsi file.
>>
>> Signed-off-by: Josef Gajdusek <atx@atx.name>
>> ---
>>  arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
>> index 4a4926b..172576d 100644
>> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
>> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
>> @@ -389,6 +389,13 @@
>>                         #size-cells = <0>;
>>                 };
>>
>> +               sid: eeprom at 01c14000 {
>> +                       compatible = "allwinner,sun4i-a10-sid";
> 
> This has been discussed before. The hardware is not compatible.
> The write control registers are at different offsets.

I'm not sure what you mean by write control registers. Code in
sunxi_sid.c implements only read access to the nvram. Can you pelase
elaborate?

  Ondrej

> 
> ChenYu
> 
>> +                       reg = <0x01c14000 0x400>;
>> +                       #address-cells = <1>;
>> +                       #size-cells = <1>;
>> +               };
>> +
>>                 usbphy: phy at 01c19400 {
>>                         compatible = "allwinner,sun8i-h3-usb-phy";
>>                         reg = <0x01c19400 0x2c>,
>> --
>> 2.9.0
>>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160624/e121c180/attachment.sig>
