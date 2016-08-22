From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 22 Aug 2016 17:04:10 +0300
Subject: [PATCH] ARM: dts: blanche: add SDHI0 support
In-Reply-To: <20160822073305.GD28034@verge.net.au>
References: <5383928.8UnDsUpmkz@wasted.cogentembedded.com>
 <3029697.f9plKzFKet@wasted.cogentembedded.com>
 <20160822073305.GD28034@verge.net.au>
Message-ID: <220d0d62-8562-8d8a-54b2-fc6e1d616e02@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/2016 10:33 AM, Simon Horman wrote:

>> Define the Blanche board dependent part of the SDHI0 (connected to the
>> micro-SD slot) device node along with  the necessary voltage regulator.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> ---
>> This patch is against the 'renesas-devel-20160817-v4.8-rc2' of Simon Horman's
>> 'renesas.git' repo plus the general purpose switches patch  posted yesterday.
>>
>>  arch/arm/boot/dts/r8a7792-blanche.dts |   25 +++++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>
>> Index: renesas/arch/arm/boot/dts/r8a7792-blanche.dts
>> ===================================================================
>> --- renesas.orig/arch/arm/boot/dts/r8a7792-blanche.dts
>> +++ renesas/arch/arm/boot/dts/r8a7792-blanche.dts
>> @@ -103,6 +103,17 @@
>>  			gpios = <&gpio11 2 GPIO_ACTIVE_LOW>;
>>  		};
>>  	};
>> +
>> +	vcc_sdhi0: regulator-vcc-sdhi0 {
>> +		compatible = "regulator-fixed";
>> +
>> +		regulator-name = "SDHI0 Vcc";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +
>> +		gpio = <&gpio11 12 GPIO_ACTIVE_HIGH>;
>> +		enable-active-high;
>> +	};
>>  };
>
> Is it intentional that there is no vccq_sdhi0 ?

    Yes, it's fixed at 3.3V.

[...]

MBR, Sergei
