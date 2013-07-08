From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 08 Jul 2013 15:13:27 +0200
Subject: [PATCH v3 08/13] ARM: dts: Add camera device nodes for Exynos4412
 TRATS2 board
In-Reply-To: <1996184.tcirO0Du7j@flatron>
References: <1372692155-17653-1-git-send-email-s.nawrocki@samsung.com>
 <1372692155-17653-9-git-send-email-s.nawrocki@samsung.com>
 <1996184.tcirO0Du7j@flatron>
Message-ID: <51DABAF7.5000201@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2013 01:23 AM, Tomasz Figa wrote:
> On Monday 01 of July 2013 17:22:30 Sylwester Nawrocki wrote:
>> This patch enables the front camera using the internal
>> camera ISP (FIMC-IS).
>>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos4412-trats2.dts |   91
>> +++++++++++++++++++++++++++++++ 1 file changed, 91 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts
>> b/arch/arm/boot/dts/exynos4412-trats2.dts index b9de3b5..e9fb3de 100644
>> --- a/arch/arm/boot/dts/exynos4412-trats2.dts
>> +++ b/arch/arm/boot/dts/exynos4412-trats2.dts
>> @@ -62,6 +62,15 @@
>>  			enable-active-high;
>>  		};
>>
>> +		cam_io_reg: voltage-regulator at 3 {
> 
> Same comment here as for patch 7/13. This is not an address of this 
> regulator, so I would rather use -3 prefix.

Yes, and this is the convention already used in this 'regulators' node.
I'll rename that node to 'voltage-regulator-1'.

>> +			compatible = "regulator-fixed";
>> +			regulator-name = "CAM_SENSOR_A";
>> +			regulator-min-microvolt = <2800000>;
>> +			regulator-max-microvolt = <2800000>;
>> +			gpio = <&gpm0 2 0>;
>> +			enable-active-high;
>> +		};
>> +
>>  		/* More to come */
>>  	};
>>
>> @@ -472,4 +481,86 @@
>>  			gpios = <&gpj0 7 0>;
>>  		};
>>  	};
>> +
>> +	camera {
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&cam_port_b_clk_active>;
>> +		status = "okay";
>> +
>> +		fimc_0: fimc at 11800000 {
>> +			clock-frequency = <160000000>;
>> +			status = "okay";
>> +		};
>> +
>> +		fimc_1: fimc at 11810000 {
>> +			clock-frequency = <160000000>;
>> +			status = "okay";
>> +		};
>> +
>> +		fimc_2: fimc at 11820000 {
>> +			clock-frequency = <160000000>;
>> +			status = "okay";
>> +		};
>> +
>> +		fimc_3: fimc at 11830000 {
>> +			clock-frequency = <160000000>;
>> +			status = "okay";
>> +		};
>> +
>> +		csis_1: csis at 11890000 {
>> +			vddcore-supply = <&ldo8_reg>;
>> +			vddio-supply = <&ldo10_reg>;
>> +			clock-frequency = <160000000>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
> 
> Hmm. Couldn't the two #properties above be moved to exynos4.dtsi instead?

Normally the port/endpoint nodes are board specific. But since the binding
requires at least one port and endpoint node, these properties will always
need to be specified. Thus it's a good idea to move them to exynos4.dtsi.

--
Thanks,
Sylwester
