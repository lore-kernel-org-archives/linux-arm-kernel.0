From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Thu, 5 Sep 2013 16:59:22 +0530
Subject: [PATCH v2 2/2] arm: dt: Exynos5420: populate cpu node enteries to
 8 cpus
In-Reply-To: <CAGm_ybintHkLEOYUg=RN4gT8iDww2jyVdtbQZ3kvNbOcO8ewVw@mail.gmail.com>
References: <1378376550-27762-1-git-send-email-chander.kashyap@linaro.org>
 <1378376550-27762-3-git-send-email-chander.kashyap@linaro.org>
 <CAGm_ybintHkLEOYUg=RN4gT8iDww2jyVdtbQZ3kvNbOcO8ewVw@mail.gmail.com>
Message-ID: <CANuQgHHGMjxWXcCMB+DSLVpybU2_88BcWZqqZTK3DS_E35fJPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vikas,

On 5 September 2013 16:09, Vikas Sajjan <sajjan.linux@gmail.com> wrote:
> Hi Chander,
>
> On Thu, Sep 5, 2013 at 3:52 PM, Chander Kashyap
> <chander.kashyap@linaro.org> wrote:
>> Exynos5420 is octacore SoC from samsung.
>> Hence populate all the cpu node enteries.
>>
>> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
>> ---
>>  arch/arm/boot/dts/exynos5420.dtsi |   28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
>> index e97c87b..0bd1a40 100644
>> --- a/arch/arm/boot/dts/exynos5420.dtsi
>> +++ b/arch/arm/boot/dts/exynos5420.dtsi
>> @@ -57,6 +57,34 @@
>>                         reg = <0x3>;
>>                         clock-frequency = <1800000000>;
>>                 };
>> +
>> +               cpu4: cpu at 0x100 {
>
>
> you are NOT suppose to use '0x' in dt node name.
> it should be  cpu4: cpu at 100 {

Ok, I will fix it.

>
>
>> +                       device_type = "cpu";
>> +                       compatible = "arm,cortex-a7";
>> +                       reg = <0x100>;
>> +                       clock-frequency = <1000000000>;
>> +               };
>> +
>> +               cpu5: cpu at 0x101 {
>
> ditto.
>
>
>> +                       device_type = "cpu";
>> +                       compatible = "arm,cortex-a7";
>> +                       reg = <0x101>;
>> +                       clock-frequency = <1000000000>;
>> +               };
>> +
>> +               cpu6: cpu at 0x102 {
>
> ditto.
>
>> +                       device_type = "cpu";
>> +                       compatible = "arm,cortex-a7";
>> +                       reg = <0x102>;
>> +                       clock-frequency = <1000000000>;
>> +               };
>> +
>> +               cpu7: cpu at 0x103 {
>
> ditto.
>
>> +                       device_type = "cpu";
>> +                       compatible = "arm,cortex-a7";
>> +                       reg = <0x103>;
>> +                       clock-frequency = <1000000000>;
>> +               };
>>         };
>>
>>         clock: clock-controller at 0x10010000 {
>> --
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
with warm regards,
Chander Kashyap
