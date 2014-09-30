From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 30 Sep 2014 08:49:31 +0100
Subject: [PATCH 1/4] ARM: DT: apq8064: add rpm support
In-Reply-To: <20140930051138.GH28481@sonymobile.com>
References: <1411982044-7873-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1411982092-7922-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20140930051138.GH28481@sonymobile.com>
Message-ID: <542A608B.5010408@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 30/09/14 06:11, Bjorn Andersson wrote:

>>
>> +		apcs: syscon at 2011000 {
>> +			compatible = "syscon";
>> +			reg = <0x2011000 0x1000>;
>> +		};
>> +
>> +		rpm at 108000 {
>> +			compatible	= "qcom,rpm-apq8064";
>> +			reg		= <0x108000 0x1000>;
>> +			qcom,ipc = <&apcs 0x8 2>;
>
> I don't like your indentation, but please stick with one way of doing it :)
>
I agree, Will fix this in next version.
>> +
>> +			interrupts	= <0 19 0>, <0 21 0>, <0 22 0>;
>> +			interrupt-names = "ack", "err", "wakeup";
>> +
>> +			#address-cells	= <1>;
>> +			#size-cells	= <0>;
>> +
>
> This part looks good.
>
> But how about adding all the regulators here as well?
Yes we can add for the sake of completeness but w.r.t testing only some 
of them will be tested
> Like:
>
>                          pm8921_l5: pm8921-l5 {
> 				compatible = "qcom,rpm-pm8921-pldo";
> 				reg = <QCOM_RPM_PM8921_LDO5>;
> 			};
>
Adding nodes like this should be trival.
> 			...
>
> That way we can update the references from this file (while still allowing the
> dts to override it if needed). I'm not sure if we should add some sane defaults
> or just completely deferr specifying the voltage ranges to the dts. The benefit
> of the latter is that the regulators not configured by the dts author will not
> be accessible.
>
> But simply listing all the nodes here would be nice and I dont see much reason
> to postpone this work.
Ok.. will be done in next version.


--srini
>
>> +		};
>> +
>>   		/* Temporary fixed regulator */
>>   		vsdcc_fixed: vsdcc-regulator {
>>   			compatible = "regulator-fixed";
>
> Regards,
> Bjorn
>
