From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 19 Feb 2016 12:51:48 +0900
Subject: [PATCH v2 1/3] ARM: dts: Add cooling levels for CPUs on exynos5420
In-Reply-To: <87h9h599zi.fsf@e105922-lin.cambridge.arm.com>
References: <1455772383-20598-1-git-send-email-k.kozlowski@samsung.com>
 <87h9h599zi.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <56C69154.40608@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.02.2016 02:58, Punit Agrawal wrote:
> Hi Krzysztof,
> 
> Krzysztof Kozlowski <k.kozlowski@samsung.com> writes:
> 
>> On Exynos5420 we support 8 cpufreq steps (600-1300 MHz) for LITTLE and
>> 12 steps for big core (700-1800 MHz). Add respective cooling cells.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>
>> ---
>>
>> Changes since v1:
>> 1. Add cooling properties to all CPUs (suggested by Viresh).
>> ---
>>  arch/arm/boot/dts/exynos5420-cpus.dtsi | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5420-cpus.dtsi b/arch/arm/boot/dts/exynos5420-cpus.dtsi
>> index 261d25173f61..5c052d7ff554 100644
>> --- a/arch/arm/boot/dts/exynos5420-cpus.dtsi
>> +++ b/arch/arm/boot/dts/exynos5420-cpus.dtsi
>> @@ -33,6 +33,9 @@
>>  			clock-frequency = <1800000000>;
>>  			cci-control-port = <&cci_control1>;
>>  			operating-points-v2 = <&cluster_a15_opp_table>;
>> +			cooling-min-level = <0>;
>> +			cooling-max-level = <11>;
> 
> Although the above two properties are defined they aren't parsed in the
> kernel.
> 
> Setting min / max extents for cooling devices via cooling maps does work
> though.

It is described as optional property in
Documentation/devicetree/bindings/thermal/thermal.txt ... but indeed it
is totally ignored.

So what is the recommendation? Get rid of it from DTS and documentation
or leave it because it will be implemented someday?

Thanks for feedback!

Best regards,
Krzysztof
