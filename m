From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 12 Jan 2016 14:30:34 +0000
Subject: [PATCH 1/5] arm64: dts: apq8016-sbc: add regulators support
In-Reply-To: <7998607.BblzgPxGPW@wuerfel>
References: <1452606358-24569-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1452606392-24614-1-git-send-email-srinivas.kandagatla@linaro.org>
 <7998607.BblzgPxGPW@wuerfel>
Message-ID: <56950E0A.2000005@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/01/16 13:59, Arnd Bergmann wrote:
> On Tuesday 12 January 2016 13:46:32 Srinivas Kandagatla wrote:
>>          };
>>
>> +       smd {
>> +               rpm {
>> +                       rpm-requests {
>> +                               pm8916-regulators {
>> +
>> +                                       vdd_l1_l2_l3-supply = <&pm8916_s3>;
>> +                                       vdd_l5-supply = <&pm8916_s3>;
>> +                                       vdd_l4_l5_l6-supply = <&pm8916_s4>;
>> +                                       vdd_l7-supply = <&pm8916_s4>;
>> +
>>
>
> If you're nested this deeply, you should consider using labels, e.g.
>
Labels are good and works for me.

Stephen/Andy are you ok to use labels for such deeply nested nodes in 
board dts?

> / {
>         ...
>
>         smd {
>                 rpm {
>                        rpm-requests {
>                                 regulators: pm8916-regulators {
>
> 				};
> 			};
> 		};
> 	};
>
> 	...
> };
>
>
> &regulators {
>          vdd_l1_l2_l3-supply = <&pm8916_s3>;
>          vdd_l5-supply = <&pm8916_s3>;
>          vdd_l4_l5_l6-supply = <&pm8916_s4>;
>          vdd_l7-supply = <&pm8916_s4>;
>
> 	s1 {
>                   regulator-min-microvolt = <375000>;
>                   regulator-max-microvolt = <1562000>;
> 	};
>
>          s3 {
> 	        regulator-min-microvolt = <375000>;
> 	        regulator-max-microvolt = <1562000>;
>          };
>
> 	...
> };
>
> btw, it seems odd to me that all those nodes under 'smd'
> have names but no addresses.
These regulators are identified by the node names, and have no addresses 
associated with it as control goes over SMD based IPC to the rpm.

https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt?id=refs/tags/next-20160112

--srini

>
> 	Arnd
>
