From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 18 Aug 2015 22:30:18 +0200
Subject: [PATCH 2/2] ARM: dts: rockchip: correct regulator PM properties
In-Reply-To: <51457775.D3ds00ymOJ@phil>
References: <1439923455-109818-1-git-send-email-briannorris@chromium.org>
 <1439923455-109818-2-git-send-email-briannorris@chromium.org>
 <51457775.D3ds00ymOJ@phil>
Message-ID: <CABxcv==hssVa-b=cOjh3QhEOmQPZVvEPt0apLHQOva3GjJb9PA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Heiko,

On Tue, Aug 18, 2015 at 9:17 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> Hi Brian,
>
>
> thanks for catching these oversights, but see below
>
> Am Dienstag, 18. August 2015, 11:44:15 schrieb Brian Norris:
>> This DTS file was submitted with non-upstream bindings. I happened
>> across this while reviewing the jaq DTS.
>>
>> Signed-off-by: Brian Norris <briannorris@chromium.org>
>> Cc: Alexandru M Stan <amstan@chromium.org>
>> Cc: Douglas Anderson <dianders@chromium.org>
>> ---
>> Tested on jaq, not minnie
>>
>>  arch/arm/boot/dts/rk3288-veyron-minnie.dts | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/rk3288-veyron-minnie.dts
>> b/arch/arm/boot/dts/rk3288-veyron-minnie.dts index
>> 0e30bd6bf92b..6f619c154dc6 100644
>> --- a/arch/arm/boot/dts/rk3288-veyron-minnie.dts
>> +++ b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
>> @@ -128,12 +128,16 @@
>>                       regulator-min-microvolt = <3300000>;
>>                       regulator-max-microvolt = <3300000>;
>>                       regulator-name = "vcc33_touch";
>> -                     regulator-suspend-mem-disabled;
>> +                     regulator-state-mem {
>> +                             regulator-on-in-suspend;
>> +                     };
>>               };
>>
>>               vcc5v_touch: SWITCH_REG2 {
>>                       regulator-name = "vcc5v_touch";
>> -                     regulator-suspend-mem-disabled;
>> +                     regulator-state-mem {
>> +                             regulator-on-in-suspend;
>> +                     };
>
> wouldn't regulator-suspend-mem-disabled translate to regulator-off-in-suspend?

Correct, the downstream regulator-suspend-mem-disabled is equivalent
to regulator-off-in-suspend in mainline.

> At least looks like it according to https://lkml.org/lkml/2013/7/25/592
>

I guess you meant https://lkml.org/lkml/2014/10/10/162 since it was
Chanwoo's and not Vincent's version that finally landed.

>
> Heiko
>

Best regards,
Javier
