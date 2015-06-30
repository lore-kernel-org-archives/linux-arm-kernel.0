From: cory.tusar@pid1solutions.com (Cory Tusar)
Date: Mon, 29 Jun 2015 22:20:29 -0400
Subject: [PATCH] ARM: dts: vf610: Extend I2C support to all available
 buses.
In-Reply-To: <36885aa1e7792b1b0bd072b1340cd5a0@agner.ch>
References: <1434327599-3739-1-git-send-email-cory.tusar@pid1solutions.com>
 <36885aa1e7792b1b0bd072b1340cd5a0@agner.ch>
Message-ID: <5591FCED.40907@pid1solutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/16/2015 04:50 AM, Stefan Agner wrote:
> On 2015-06-15 02:19, Cory Tusar wrote:
>> This commit extends the existing Vybrid I2C support to cover buses i2c1,
>> i2c2, and i2c3.  Based in (very) large part on an initial patch by
>> Stefan Agner that was just lacking a couple of DMA assignments.
>>
>> Signed-off-by: Cory Tusar <cory.tusar@pid1solutions.com>
> 
> Thx Cory for picking that up.
> 
> So with that patch we use the second Mux of DMA0 the first time. Another
> option would have been to use the first Mux of DMA1, however I think its
> better to leave DMA1 for dedicated purposes or the secondary Cortex-M4
> core... If a board needs different configuration, one would also have
> the option to overwrite the properties.
> 
> Acked-by: Stefan Agner <stefan@agner.ch>

Just a status check on this...any additional comments?

Regards,
- -Cory


>> ---
>>  arch/arm/boot/dts/vfxxx.dtsi | 41 +++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 41 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
>> index 4aa3351..25f2615 100644
>> --- a/arch/arm/boot/dts/vfxxx.dtsi
>> +++ b/arch/arm/boot/dts/vfxxx.dtsi
>> @@ -347,6 +347,20 @@
>>  				status = "disabled";
>>  			};
>>  
>> +			i2c1: i2c at 40067000 {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				compatible = "fsl,vf610-i2c";
>> +				reg = <0x40067000 0x1000>;
>> +				interrupts = <72 IRQ_TYPE_LEVEL_HIGH>;
>> +				clocks = <&clks VF610_CLK_I2C1>;
>> +				clock-names = "ipg";
>> +				dmas = <&edma0 0 52>,
>> +					<&edma0 0 53>;
>> +				dma-names = "rx","tx";
>> +				status = "disabled";
>> +			};
>> +
>>  			clks: ccm at 4006b000 {
>>  				compatible = "fsl,vf610-ccm";
>>  				reg = <0x4006b000 0x1000>;
>> @@ -520,6 +534,33 @@
>>  				status = "disabled";
>>  			};
>>  
>> +			i2c2: i2c at 400e6000 {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				compatible = "fsl,vf610-i2c";
>> +				reg = <0x400e6000 0x1000>;
>> +				interrupts = <73 IRQ_TYPE_LEVEL_HIGH>;
>> +				clocks = <&clks VF610_CLK_I2C2>;
>> +				clock-names = "ipg";
>> +				dmas = <&edma0 1 36>,
>> +					<&edma0 1 37>;
>> +				dma-names = "rx","tx";
>> +				status = "disabled";
>> +			};
>> +
>> +			i2c3: i2c at 400e7000 {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				compatible = "fsl,vf610-i2c";
>> +				reg = <0x400e7000 0x1000>;
>> +				interrupts = <74 IRQ_TYPE_LEVEL_HIGH>;
>> +				clocks = <&clks VF610_CLK_I2C3>;
>> +				clock-names = "ipg";
>> +				dmas = <&edma0 1 38>,
>> +					<&edma0 1 39>;
>> +				dma-names = "rx","tx";
>> +				status = "disabled";
>> +			};
>>  		};
>>  	};
>>  };
> 


- -- 
Cory Tusar
Principal
PID 1 Solutions, Inc.


"There are two ways of constructing a software design.  One way is to
 make it so simple that there are obviously no deficiencies, and the
 other way is to make it so complicated that there are no obvious
 deficiencies."  --Sir Charles Anthony Richard Hoare

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlWR/O0ACgkQHT1tsfGwHJ9+zgCfRPTTiszNMsDy8nVnfdjIYGGO
iv0An2go86s+1hbrpAF1VbpCrKmYqF0J
=EatS
-----END PGP SIGNATURE-----
