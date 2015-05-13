From: linux.amoon@gmail.com (Anand Moon)
Date: Wed, 13 May 2015 15:37:37 +0530
Subject: [PATCHv5 4/5] ARM: dts: exynos5420 update the cooling cells for
 core cpu0
In-Reply-To: <CAJKOXPdKtMO3f8YzHXtuZ042jkFRL4wa978=TggSQk8FahubRg@mail.gmail.com>
References: <1431499020-3912-1-git-send-email-linux.amoon@gmail.com>
 <1431499020-3912-5-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPdKtMO3f8YzHXtuZ042jkFRL4wa978=TggSQk8FahubRg@mail.gmail.com>
Message-ID: <CANAwSgTdQk6BGD4xxB6k=p=YOV+CHv_+Q_bSyrxiPsdXVps92g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 May 2015 at 13:01, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
> 2015-05-13 15:36 GMT+09:00 Anand Moon <linux.amoon@gmail.com>:
>> update the cooling level for cpu0 to avoid following message.
>
> Capitalize sentence.
> In commit subject add missing colon after "exynos5420".
>
>>
>> root at odroidxu3:~# dmesg | grep ther
>
> This command not needed, we all know how to use dmesg and grep.
>
>> [    0.241511] /thermal-zones/cpu-thermal/cooling-maps/map0:
>>                          could not get #cooling-cells for /cpus/cpu at 0
>>
>> Tested-by: Markus Reichl <m.reichl@fivetechno.de>
>> Acked-by: Lukasz Majewski <l.majewski@samsung.com>
>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>> ---
>>  arch/arm/boot/dts/exynos5420.dtsi | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
>> index 4531753..c75ed16 100644
>> --- a/arch/arm/boot/dts/exynos5420.dtsi
>> +++ b/arch/arm/boot/dts/exynos5420.dtsi
>> @@ -61,6 +61,10 @@
>>                         reg = <0x0>;
>>                         clock-frequency = <1800000000>;
>>                         cci-control-port = <&cci_control1>;
>> +
>> +                       cooling-min-level = <10>;
>> +                       cooling-max-level = <7>;
>> +                       #cooling-cells = <2>; /* min followed by max */
>
> I might be missing something but I do not understand which cooling
> levels are referenced here. In my exynos5420.dtsi file there are no
> frequencies for cpu0 node. Could you help me understand this?
>
> Best regards,
> Krzysztof

Hi Krzysztof,

http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt
http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/thermal/thermal.txt#L201

These two documents provide the description on cooling-min-level and
cooling-max-level.

I will correctly update the value in the next updated patch.

-Anand Moon
