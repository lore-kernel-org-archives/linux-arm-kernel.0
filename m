From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 24 Apr 2014 17:33:03 +0300
Subject: [PATCH 11/23] ARM: dts: omap5-uevm.dts: add tca6424a
In-Reply-To: <53591669.7060502@cogentembedded.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
 <1398334639-14172-12-git-send-email-tomi.valkeinen@ti.com>
 <53591669.7060502@cogentembedded.com>
Message-ID: <5359209F.7000308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/04/14 16:49, Sergei Shtylyov wrote:
> Hello.
> 
> On 24-04-2014 14:17, Tomi Valkeinen wrote:
> 
>> omap5-uevm has a tca6424a I/O expander. Add it to the .dts file.
> 
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> ---
>>   arch/arm/boot/dts/omap5-uevm.dts | 7 +++++++
>>   1 file changed, 7 insertions(+)
> 
>> diff --git a/arch/arm/boot/dts/omap5-uevm.dts
>> b/arch/arm/boot/dts/omap5-uevm.dts
>> index 3b99ec25b748..9e7581eaeb23 100644
>> --- a/arch/arm/boot/dts/omap5-uevm.dts
>> +++ b/arch/arm/boot/dts/omap5-uevm.dts
>> @@ -434,6 +434,13 @@
>>       pinctrl-0 = <&i2c5_pins>;
>>
>>       clock-frequency = <400000>;
>> +
>> +    tca6424a: tca6424a at 22 {
> 
>    The ePAPR standard [1] says: "The name of a node should be somewhat
> generic,
> reflecting the function of the device and not its precise programming
> model.
> If appropriate, the name should be one of the following choices:
> [...]
>    - gpio;"

Right. I wonder what the name should be... "gpio" is out, as the name
should be more specific. We already have gpio1-8, which are the gpio
banks from the SoC. It could be 'gpio9', but that makes it sound it's
just one more SoC gpio bank. 'gpio-expander1'?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140424/3bf9345d/attachment.sig>
