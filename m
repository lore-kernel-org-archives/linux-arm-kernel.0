From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 30 Sep 2014 09:16:55 +0100
Subject: [PATCH 2/4] ARM: DT: apq8064: Add usb host support.
In-Reply-To: <20140930051728.GI28481@sonymobile.com>
References: <1411982044-7873-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1411982100-7964-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20140930051728.GI28481@sonymobile.com>
Message-ID: <542A66F7.2000607@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 30/09/14 06:17, Bjorn Andersson wrote:
> On Mon 29 Sep 02:15 PDT 2014, Srinivas Kandagatla wrote:
>
>> This patch adds device tree nodes to support two usb hosts on APQ8064
>> SOC.

>> +				compatible	= "qcom,rpm-pm8921-smps";
>> +				reg		= <QCOM_RPM_PM8921_SMPS3>;
>> +
>> +				regulator-min-microvolt = <1000000>;
>> +				regulator-max-microvolt = <1400000>;
>> +				qcom,boot-load 		= <49360>;
>
> As it was unclear how to handle load in the driver I dropped boot-load for now.
> Please leave it out until someone have added it to the driver.

Ok, will drop this in next version.

>
>> +				regulator-always-on;
>
> Why are all these "always-on"?
I added this for a regulator which was shared between hdmi and sata, I 
think for other regualtors this was just a copy paste error. I will 
recheck it once again and send a new version.

thanks,
srini
>
>> +			};
>> +
>> +		};
>> +
>>
>>   		/* Temporary fixed regulator */
>> --
>> 1.9.1
>>
