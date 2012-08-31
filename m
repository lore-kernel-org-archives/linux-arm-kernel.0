From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Fri, 31 Aug 2012 11:47:19 +0530
Subject: [PATCH RESEND v4 1/3] arm/dts: AM33XX: Add basic pinctrl device
 tree data
In-Reply-To: <20120830203234.GA1303@atomide.com>
References: <1346141454-18786-1-git-send-email-anilkumar@ti.com>
 <1346141454-18786-2-git-send-email-anilkumar@ti.com>
 <20120830203234.GA1303@atomide.com>
Message-ID: <504056EF.8010205@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 8/31/2012 2:02 AM, Tony Lindgren wrote:
> * AnilKumar Ch <anilkumar@ti.com> [120828 01:11]:
>> Adds basic pinctrl device tree data for AM33XX family of devices.
>> This patch is based on the pinctrl-single driver.
>>
>> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
>> ---
>>  arch/arm/boot/dts/am33xx.dtsi |    9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
>> index dde76f7..dfe9c559 100644
>> --- a/arch/arm/boot/dts/am33xx.dtsi
>> +++ b/arch/arm/boot/dts/am33xx.dtsi
>> @@ -40,6 +40,15 @@
>>  		};
>>  	};
>>  
>> +	am3358_pinmux: pinmux at 44E10800 {
>> +		compatible = "pinctrl-single";
>> +		reg = <0x44E10800 0x0238>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		pinctrl-single,register-width = <32>;
>> +		pinctrl-single,function-mask = <0x7F>;
>> +	};
>> +
> 
> Nit: Please use lower case for the hex numbers as that's the
> standard in Linux kernel.
> 

Tony,

I could see that you have already merged the patch from Anil for
regulator support in bone & evm dts file, which has uppper-case hex numbers.
Request you to merge the patch which I submitted to convert all hex
numbers to lower-case and then merge all dts changes only with
lower-case presentation.

http://www.mail-archive.com/linux-omap at vger.kernel.org/msg74393.html

Thanks,
Vaibhav
> Tony
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 
