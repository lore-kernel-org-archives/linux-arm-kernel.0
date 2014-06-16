From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Mon, 16 Jun 2014 12:31:23 +0530
Subject: [PATCH RFC v2 4/7] ARM: dts: Add PPMU device tree support for
 Exynos5420
In-Reply-To: <537E38F5.4020200@cogentembedded.com>
References: <1400779322-4410-1-git-send-email-a.kesavan@samsung.com>
 <1400779322-4410-5-git-send-email-a.kesavan@samsung.com>
 <537E38F5.4020200@cogentembedded.com>
Message-ID: <CAM4voamge5W=YRb2WDSQjgTae-oeAiaUqx9ykLsQ0w1E-4LqsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Thu, May 22, 2014 at 11:20 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 05/22/2014 09:21 PM, Abhilash Kesavan wrote:
>
>> PPMU is required by the exynos5420 devfreq driver. Add a device
>> tree node for it.
>
>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> ---
>>   arch/arm/boot/dts/exynos5420.dtsi |    7 +++++++
>>   1 file changed, 7 insertions(+)
>
>
>> diff --git a/arch/arm/boot/dts/exynos5420.dtsi
>> b/arch/arm/boot/dts/exynos5420.dtsi
>> index 8e7e35c..6ab7b03 100644
>> --- a/arch/arm/boot/dts/exynos5420.dtsi
>> +++ b/arch/arm/boot/dts/exynos5420.dtsi
>> @@ -833,4 +833,11 @@
>>                 samsung,pmu-syscon = <&pmu_system_controller>;
>>                 #phy-cells = <1>;
>>         };
>> +
>> +       ppmu {
>
>
>    Shouldn't it have the unit-address part, like "ppmu at 10d00000"?
Will fix.

Regards,
Abhilash
>
>
>> +               compatible = "samsung,exynos5420-int-busfreq";
>> +               reg = <0x10D00000 0x2000        /* PPMU_DMC_0_0 */
>> +                      0x10D10000 0x2000        /* PPMU_DMC_0_1 */
>> +                      0x10D60000 0x2000>;      /* PPMU_DMC_1_0 */
>> +       };
>>   };
>
>
> WBR, Sergei
>
