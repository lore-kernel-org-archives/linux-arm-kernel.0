From: scott.branden@broadcom.com (Scott Branden)
Date: Mon, 4 Jul 2016 09:59:48 -0700
Subject: [PATCH v4 3/3] ARM:dts-Add dt node for Broadcom iproc-static-adc
In-Reply-To: <184c47dc-6cdb-c314-9f29-7b03d5784de6@kernel.org>
References: <1467099636-31855-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <1467099636-31855-4-git-send-email-raveendra.padasalagi@broadcom.com>
 <184c47dc-6cdb-c314-9f29-7b03d5784de6@kernel.org>
Message-ID: <577A9604.90702@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Florian,

Patch to apply

On 16-07-03 03:34 AM, Jonathan Cameron wrote:
> On 28/06/16 08:40, Raveendra Padasalagi wrote:
>> This patch adds DT node for Broadcom's iproc-static-adc
>> controller driver.
>>
>> Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Driver is working its way towards just making the next merge window...
>
> Guessing this will go through the relevant path to the arm-soc tree
> as normal.
Florian, can you add to next pull request?

>
> Thanks,
>
> Jonathan
>> ---
>>   arch/arm/boot/dts/bcm-cygnus.dtsi | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
>> index b42fe55..fabc9f3 100644
>> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
>> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
>> @@ -366,5 +366,16 @@
>>   			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
>>   			status = "disabled";
>>   		};
>> +
>> +		adc: adc at 180a6000 {
>> +			compatible = "brcm,iproc-static-adc";
>> +			#io-channel-cells = <1>;
>> +			io-channel-ranges;
>> +			adc-syscon = <&ts_adc_syscon>;
>> +			clocks = <&asiu_clks BCM_CYGNUS_ASIU_ADC_CLK>;
>> +			clock-names = "tsc_clk";
>> +			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
>> +			status = "disabled";
>> +		};

Thanks,
  Scott
>>   	};
>>   };
>>
>
