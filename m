From: robherring2@gmail.com (Rob Herring)
Date: Mon, 29 Jul 2013 08:13:22 -0500
Subject: [PATCH 7/7] dts: calxeda: add ARM PSCI binding
In-Reply-To: <20130729102424.GA24255@e106331-lin.cambridge.arm.com>
References: <1375048598-15637-1-git-send-email-robherring2@gmail.com>
 <1375048598-15637-8-git-send-email-robherring2@gmail.com>
 <20130729102424.GA24255@e106331-lin.cambridge.arm.com>
Message-ID: <51F66A72.7070209@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/2013 05:24 AM, Mark Rutland wrote:
> On Sun, Jul 28, 2013 at 10:56:38PM +0100, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> Add the PSCI binding for Calxeda SOCs. The PSCI function numbers are
>> different from the DT binding example because the numbering changed in
>> revisions of the PSCI spec and are already fixed in highbank firmware.
>> Since the numbering is transparent to the kernel, this difference is not
>> significant.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> ---
>>  arch/arm/boot/dts/ecx-common.dtsi | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/ecx-common.dtsi b/arch/arm/boot/dts/ecx-common.dtsi
>> index e8559b7..f1dfc09 100644
>> --- a/arch/arm/boot/dts/ecx-common.dtsi
>> +++ b/arch/arm/boot/dts/ecx-common.dtsi
>> @@ -19,6 +19,16 @@
>>  		bootargs = "console=ttyAMA0";
>>  	};
>>  
>> +	psci {
>> +		compatible	= "arm,psci";
>> +		method		= "smc";
>> +		cpu_suspend	= <0x84000002>;
>> +		cpu_off		= <0x84000004>;
>> +		cpu_on		= <0x84000006>;
>> +		system_off	= <0x84000100>;
>> +		system_reset	= <0x84000101>;
>> +	};
>> +
> 
> I see this is somewhat beyond the original PSCI, given the addition of
> SYSTEM_OFF and SYSTEM_RESET, but not quite PSCI 0.2 as you don't have
> PSCI_VERSION.

I do actually support PSCI_VERSION. Forgot to add that to the dts.

> It would be nice it the compatible string were more specific here to
> deal with this and any implementation-specific power_state ID values.
> Something like "calxeda,highbank-psci", "arm,psci" ?

Is that something we always want to do? You can't really know the
implementation quirks up front.

Rob
