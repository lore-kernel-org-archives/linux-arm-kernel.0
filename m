From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 26 Mar 2014 10:27:39 +0100
Subject: [PATCH 15/20] ARM: ux500: Add a vmmc regulator through DT for the
 poped eMMC for href
In-Reply-To: <CACRpkdbFFqQdWXOHyV8qmxnd0z2CKK9gZFS0ys5YLm2dES7bgQ@mail.gmail.com>
References: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
 <1395404057-27835-16-git-send-email-ulf.hansson@linaro.org>
 <CACRpkdbFFqQdWXOHyV8qmxnd0z2CKK9gZFS0ys5YLm2dES7bgQ@mail.gmail.com>
Message-ID: <CAPDyKFq3CqSwwJ9F8mAYAckOGqM89aH0OG7jwrA0XaQV1QW3=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 March 2014 22:45, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Mar 21, 2014 at 1:14 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>> Add a node in DT for the proper regulator which means we can move away
>> from the mmci platform data which currently holds the corresponding OCR
>> mask.
>>
>> The mmci driver can then calculate the OCR mask based on the voltages
>> supported by the regulator, instead of relying on the platform data.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  arch/arm/boot/dts/ste-href.dtsi |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
>> index be34beb..bf449de 100644
>> --- a/arch/arm/boot/dts/ste-href.dtsi
>> +++ b/arch/arm/boot/dts/ste-href.dtsi
>> @@ -155,6 +155,7 @@
>>                         bus-width = <8>;
>>                         cap-mmc-highspeed;
>>                         non-removable;
>> +                       vmmc-supply = <&db8500_vsmps2_reg>;
>
> Don't you need a similar oneliner to ste-snowball.dts?
> That board is not including this file...

Snowball don't have the poped eMMC, which mean the vsmps2 is not used
as the vmmc-supply.

I still plan to have a look at snowball, handled as a separate task,
since I have heard people complaining about the SD card and/or the
eMMC is working properly.

Kind regards
Ulf Hansson

>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij
