From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 30 Sep 2014 08:44:13 +0100
Subject: [PATCH 1/4] ARM: DT: apq8064: add rpm support
In-Reply-To: <5429DA95.80505@codeaurora.org>
References: <1411982044-7873-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1411982092-7922-1-git-send-email-srinivas.kandagatla@linaro.org>
 <5429DA95.80505@codeaurora.org>
Message-ID: <542A5F4D.8070407@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 29/09/14 23:17, Stephen Boyd wrote:
> On 09/29/14 02:14, Srinivas Kandagatla wrote:
>> @@ -246,6 +247,24 @@
>>   			#reset-cells = <1>;
>>   		};
>>
>> +		apcs: syscon at 2011000 {
>> +			compatible = "syscon";
>> +			reg = <0x2011000 0x1000>;
>> +		};
>
> This is actually a clock controller block that hw designers decided was
> good place to shove the ipc bits (because there's room!). Can we call it
>
>                  l2cc: clock-controller at 2011000 {
>                          compatible = "syscon";
>                          reg = <0x2011000 0x1000>;
>                  };
>
yep, I will rename this in next version.

> Eventually I'll add the specific krait compatible when we merge krait
> clock support:
sounds good.

--srini
>
>                  l2cc: clock-controller at 2011000 {
>                          compatible = "qcom,kpss-gcc", "syscon";
>                          reg = <0x2011000 0x1000>;
>                          clock-output-names = "acpu_l2_aux";
>                  };
>
>> +
>> +		rpm at 108000 {
>> +			compatible	= "qcom,rpm-apq8064";
>> +			reg		= <0x108000 0x1000>;
>> +			qcom,ipc = <&apcs 0x8 2>;
>
> There are actually 3 ipc bits. I guess if we ever have to use the other
> two we'll extend this binding to have the other bits specified some
> other way?
>
