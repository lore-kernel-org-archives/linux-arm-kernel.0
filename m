From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 11 Oct 2013 11:43:55 +0530
Subject: [PATCH 1/2] ARM: dts: omap5-uevm: remove always_on, boot_on from
 smps10_out1
In-Reply-To: <20131010141949.GA13277@kahuna>
References: <1381402195-29257-1-git-send-email-kishon@ti.com>
 <20131010141949.GA13277@kahuna>
Message-ID: <52579723.6080209@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 October 2013 07:49 PM, Nishanth Menon wrote:
> On 16:19-20131010, Kishon Vijay Abraham I wrote:
>> smps10 should be enabled only in the case of host mode. So stop
>> doing always_on, boot_on from smps10_out1. The driver will enable it in host
>> mode.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  arch/arm/boot/dts/omap5-uevm.dts |    2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
>> index d784b3a..e06a04a 100644
>> --- a/arch/arm/boot/dts/omap5-uevm.dts
>> +++ b/arch/arm/boot/dts/omap5-uevm.dts
>> @@ -334,8 +334,6 @@
>>  					regulator-name = "smps10_out1";
>>  					regulator-min-microvolt = <5000000>;
>>  					regulator-max-microvolt = <5000000>;
>> -					regulator-always-on;
>> -					regulator-boot-on;
>>  				};
>>  
>>  				ldo1_reg: ldo1 {
>> -- 
> Always good to get rid of regulator-always-on. Thanks for it.
> 
> regulator-boot-on indicates that PMIC enables it by default as part of
> OTP or some internal behavior -> Looking at the measurements done on
> uEVM and OTP information -> regulator-boot-on should be kept here.

No. Actually I don?t want PMIC to enable it by default. I want the palmas-usb
driver to handle it.
Enabling it by default makes palmas-usb to detect VBUS interrupt. This should
ideally be detected only when you connect a host cable.
Btw I didn't exactly get why you want regulator-boot-on should be kept here.

Thanks
Kishon
