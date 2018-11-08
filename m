From: elder@linaro.org (Alex Elder)
Date: Thu, 8 Nov 2018 10:22:12 -0600
Subject: [RFC PATCH 12/12] soc: qcom: ipa: build and "ipa_i.h"
In-Reply-To: <cebe0d3c-4a24-60a4-88c8-5195a5d0da4b@infradead.org>
References: <20181107003250.5832-1-elder@linaro.org>
 <20181107003250.5832-13-elder@linaro.org>
 <cebe0d3c-4a24-60a4-88c8-5195a5d0da4b@infradead.org>
Message-ID: <dd788545-a369-684e-3d57-b0b8a98b407a@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/6/18 6:40 PM, Randy Dunlap wrote:
> Hi-

Thanks Randy, I've fixed this in my own tree.	-Alex

> 
> On 11/6/18 4:32 PM, Alex Elder wrote:
>> diff --git a/drivers/net/ipa/Kconfig b/drivers/net/ipa/Kconfig
>> new file mode 100644
>> index 000000000000..f8ea9363f532
>> --- /dev/null
>> +++ b/drivers/net/ipa/Kconfig
>> @@ -0,0 +1,30 @@
>> +config IPA
>> +	tristate "Qualcomm IPA support"
>> +	depends on NET
>> +	select QCOM_QMI_HELPERS
>> +	select QCOM_MDT_LOADER
>> +	default n
>> +	help
>> +	  Choose Y here to include support for the Qualcomm IP
>> +	  Accelerator (IPA), a hardware block present in some
>> +	  Qualcomm SoCs.  The IPA is a programmable protocol
>> +	  processor that is capable of generic hardware handling
>> +	  of IP packets, including routing, filtering, and NAT.
>> +	  Currently the IPA driver supports only basic transport
>> +	  of network traffic between the AP and modem, on the
>> +	  Qualcomm SDM845 SoC.
>> +
>> +	  If unsure, say N.
>> +
>> +config IPA_ASSERT
>> +	bool "Enable IPA assertions"
>> +	depends on IPA
>> +	default y
>> +	help
>> +	 Incorporate IPA assertion verification in the build.  This
>> +	 cause various design assumptions to be checked at runtime,
> 
> 	 causes
> 
>> +	 generating a report (and a crash) if any assumed condition
>> +	 does not hold.  You may wish to disable this to avoid the
>> +	 overhead of checking.
>> +
>> +	 If unsure doubt, say "Y" here.
> 
> 
