From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Mon, 9 Jul 2018 16:57:29 +0530
Subject: [PATCH v4 6/6] arm64: dts: sdm845: Add tsens nodes
In-Reply-To: <153089827550.143105.2506072427444330254@swboyd.mtv.corp.google.com>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
 <a52b77ad84867774a0659f51ccb79b17ba7638ab.1530533998.git.amit.kucheria@linaro.org>
 <153089827550.143105.2506072427444330254@swboyd.mtv.corp.google.com>
Message-ID: <CAHLCerMDxhFkoK_yXznOi-ZnDskiD0-xtqEb9Pz5MRFTdbx1ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 6, 2018 at 11:01 PM, Stephen Boyd <swboyd@chromium.org> wrote:
> Quoting Amit Kucheria (2018-07-02 05:44:09)
>> SDM845 has two tsens blocks, one with 13 sensors and the other with 8
>> sensors.
>>
>> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index cdaabeb..edf8505 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -221,6 +221,22 @@
>>                         #interrupt-cells = <2>;
>>                 };
>>
>> +               tsens0: tsens at c222000 {
>
> These unit addresses should match the first reg property, not the second
> one.

Fixed in v5. Thanks.

>> +                       compatible = "qcom,tsens-v2.4.0", "qcom,tsens-v2";
>> +                       reg = <0xc263000 0x1ff>, /* TM */
>> +                             <0xc222000 0x1ff>; /* SROT */
>> +                       #qcom,sensors = <13>;
>> +                       #thermal-sensor-cells = <1>;
>> +               };
>> +
>> +               tsens1: tsens at c223000 {
>> +                       compatible = "qcom,tsens-v2.4.0", "qcom,tsens-v2";
>> +                       reg = <0xc265000 0x1ff>, /* TM */
>> +                             <0xc223000 0x1ff>; /* SROT */
>> +                       #qcom,sensors = <8>;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
