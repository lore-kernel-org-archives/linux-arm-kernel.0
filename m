From: gdjakov@mm-sol.com (Georgi Djakov)
Date: Fri, 05 Sep 2014 18:59:10 +0300
Subject: [PATCH v3] ARM: dts: qcom: Add initial IFC6540 board device tree
In-Reply-To: <5409C803.8060007@suse.de>
References: <1409763031-16873-1-git-send-email-gdjakov@mm-sol.com>
 <5409C803.8060007@suse.de>
Message-ID: <5409DDCE.7080106@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 09/05/2014 05:26 PM, Andreas F?rber wrote:
<...>
>> +			reg-names = "hc_mem", "core_mem";
>> +			interrupts = <0 123 0>, <0 138 0>;
>
> I see that you've used GPIO_ACTIVE_* above. Is the trailing zero here
> possibly IRQ_TYPE_NONE?
>

Yes, it is. Will update it. Thanks!

>> +			interrupt-names = "hc_irq", "pwr_irq";
>> +			clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
>> +			clock-names = "core", "iface";
>> +			status = "disabled";
>> +		};
>> +
>> +		sdhci at f98a4900 {
>> +			compatible = "qcom,sdhci-msm-v4";
>> +			reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
>> +			reg-names = "hc_mem", "core_mem";
>> +			interrupts = <0 125 0>, <0 221 0>;
>> +			interrupt-names = "hc_irq", "pwr_irq";
>> +			clocks = <&gcc GCC_SDCC2_APPS_CLK>, <&gcc GCC_SDCC2_AHB_CLK>;
>> +			clock-names = "core", "iface";
>> +			status = "disabled";
>> +		};
>
> If you assign labels to these two nodes, you can reference them in the
> .dts as &labelname {...};. Same for the uart node. That avoids
> duplicating the hierarchy, detects spelling mistakes at compile time and
> reduces indentation. Cf. the recent ifc6410 patch.

Sure, adding a label will not hurt.

>
> Also, is sdhci the best node name here? Usually it's not supposed to
> reflect the exact interface used (e.g., usb vs. ehci).
>

Ok, I'll figure out something better.

>>   	};
>>   };
>
> Otherwise looks good.
>

Thanks for reviewing!

BR,
Georgi
