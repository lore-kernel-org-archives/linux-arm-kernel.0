From: punit.agrawal@arm.com (Punit Agrawal)
Date: Fri, 25 Sep 2015 15:37:33 +0100
Subject: [PATCH v4 5/5] arm64: dts: Add sensor node to Juno dt
In-Reply-To: <20150924163658.GH2368@e106497-lin.cambridge.arm.com> (Liviu
 Dudau's message of "Thu, 24 Sep 2015 17:36:58 +0100")
References: <1442335861-7282-1-git-send-email-punit.agrawal@arm.com>
 <1442335861-7282-6-git-send-email-punit.agrawal@arm.com>
 <20150924163658.GH2368@e106497-lin.cambridge.arm.com>
Message-ID: <9hhd1x6bm4y.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Liviu Dudau <Liviu.Dudau@arm.com> writes:

> On Tue, Sep 15, 2015 at 05:51:01PM +0100, Punit Agrawal wrote:
>> The SCP firmware on Juno provides access to SoC sensors via the
>> SCPI. Add the sensor nodes to the device tree to enable this support.
>> 
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Liviu Dudau <liviu.dudau@arm.com>
>
> Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Thanks Liviu!

>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  arch/arm64/boot/dts/arm/juno-base.dtsi | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
>> index c624208..dd5158e 100644
>> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
>> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
>> @@ -96,6 +96,11 @@
>>  				clock-output-names = "pxlclk0", "pxlclk1";
>>  			};
>>  		};
>> +
>> +		scpi_sensors0: sensors {
>> +			compatible = "arm,scpi-sensors";
>> +			#thermal-sensor-cells = <1>;
>> +		};
>>  	};
>>  
>>  	/include/ "juno-clocks.dtsi"
>> -- 
>> 2.5.1
>> 
