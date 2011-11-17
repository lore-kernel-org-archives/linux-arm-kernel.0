From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 17 Nov 2011 14:12:22 +0530
Subject: [PATCH 3/3] ARM: omap: pass minimal SoC/board data for UART from
 dt
In-Reply-To: <4EC45D9B.5020006@gmail.com>
References: <1321441346-19591-1-git-send-email-rnayak@ti.com>
 <1321441346-19591-4-git-send-email-rnayak@ti.com>
 <4EC45D9B.5020006@gmail.com>
Message-ID: <4EC4C8EE.30701@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 November 2011 06:34 AM, Rob Herring wrote:
> On 11/16/2011 05:02 AM, Rajendra Nayak wrote:
>> Pass minimal data needed for console boot, from dt, for
>> OMAP4 panda/sdp and OMAP3 beagle boards, and get rid of the
>> static initialization from generic board file.
>>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>> ---
>>   arch/arm/boot/dts/omap3-beagle.dts  |   17 +++++++++++++++++
>>   arch/arm/boot/dts/omap3.dtsi        |   27 +++++++++++++++++++++++++++
>>   arch/arm/boot/dts/omap4-panda.dts   |   17 +++++++++++++++++
>>   arch/arm/boot/dts/omap4-sdp.dts     |   17 +++++++++++++++++
>>   arch/arm/boot/dts/omap4.dtsi        |   24 ++++++++++++++++++++++++
>>   arch/arm/mach-omap2/board-generic.c |    1 -
>>   6 files changed, 102 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
>> index 9486be6..4c8f11e 100644
>> --- a/arch/arm/boot/dts/omap3-beagle.dts
>> +++ b/arch/arm/boot/dts/omap3-beagle.dts
>> @@ -27,3 +27,20 @@
>>   		reg =<0x80000000 0x20000000>; /* 512 MB */
>>   	};
>>   };
>> +
>> +&uart1 {
>> +	clock-frequency =<48000000>;
>> +};
>> +
>> +&uart2 {
>> +	clock-frequency =<48000000>;
>> +};
>> +
>> +&uart3 {
>> +	ti,console_hwmod;
>> +	clock-frequency =<48000000>;
>> +};
>> +
>> +&uart4 {
>> +	clock-frequency =<48000000>;
>> +};
>> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
>> index d202bb5..ea591c5 100644
>> --- a/arch/arm/boot/dts/omap3.dtsi
>> +++ b/arch/arm/boot/dts/omap3.dtsi
>> @@ -13,6 +13,13 @@
>>   / {
>>   	compatible = "ti,omap3430", "ti,omap3";
>>
>> +	aliases {
>> +		uart1 =&uart1;
>> +		uart2 =&uart2;
>> +		uart3 =&uart3;
>> +		uart4 =&uart4;
>> +	};
>> +
>>   	cpus {
>>   		cpu at 0 {
>>   			compatible = "arm,cortex-a8";
>> @@ -59,5 +66,25 @@
>>   			interrupt-controller;
>>   			#interrupt-cells =<1>;
>>   		};
>> +
>> +		uart1: uart at 1 {
>
> Use the generic name serial and the address: uart1: serial at 1234abcd

ok.

>
>> +			compatible = "ti,omap-uart";
>> +			ti,hwmods = "uart1";
>> +		};
>> +
>> +		uart2: uart at 2 {
>> +			compatible = "ti,omap-uart";
>> +			ti,hwmods = "uart2";
>> +		};
>> +
>> +		uart3: uart at 3 {
>> +			compatible = "ti,omap-uart";
>> +			ti,hwmods = "uart3";
>> +		};
>> +
>> +		uart4: uart at 4 {
>> +			compatible = "ti,omap-uart";
>> +			ti,hwmods = "uart4";
>> +		};
>>   	};
>>   };
>> diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
>> index c702657..aa65449 100644
>> --- a/arch/arm/boot/dts/omap4-panda.dts
>> +++ b/arch/arm/boot/dts/omap4-panda.dts
>> @@ -27,3 +27,20 @@
>>   		reg =<0x80000000 0x40000000>; /* 1 GB */
>>   	};
>>   };
>> +
>> +&uart1 {
>> +	clock-frequency =<48000000>;
>> +};
>> +
>> +&uart2 {
>> +	clock-frequency =<48000000>;
>> +};
>> +
>> +&uart3 {
>> +	ti,console_hwmod;
>> +	clock-frequency =<48000000>;
>> +};
>> +
>> +&uart4 {
>> +	clock-frequency =<48000000>;
>> +};
>> diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
>> index 066e28c..524f5bf 100644
>> --- a/arch/arm/boot/dts/omap4-sdp.dts
>> +++ b/arch/arm/boot/dts/omap4-sdp.dts
>> @@ -27,3 +27,20 @@
>>   		reg =<0x80000000 0x40000000>; /* 1 GB */
>>   	};
>>   };
>> +
>> +&uart1 {
>> +	clock-frequency =<48000000>;
>> +};
>> +
>> +&uart2 {
>> +	clock-frequency =<48000000>;
>> +};
>> +
>> +&uart3 {
>> +	ti,console_hwmod;
>> +	clock-frequency =<48000000>;
>> +};
>> +
>> +&uart4 {
>> +	clock-frequency =<48000000>;
>
> It doesn't seem that this frequency ever varies and is likely to be
> replaced with clock bindings, so maybe just put it in the dtsi files.

sure, will do.

regards,
Rajendra
>
> Rob
>
