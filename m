From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 7 Jan 2017 14:33:47 -0500
Subject: [PATCH 14/22] dt-bindings: power: supply: add AXP20X/AXP22X
 battery DT binding
In-Reply-To: <20170104132107.tciklylgqvhftb6f@rob-hp-laptop>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-15-quentin.schulz@free-electrons.com>
 <20170104132107.tciklylgqvhftb6f@rob-hp-laptop>
Message-ID: <3155ba16-b51a-9306-6be4-0bdf4482a679@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/01/17 08:21, Rob Herring wrote:
> On Mon, Jan 02, 2017 at 05:37:14PM +0100, Quentin Schulz wrote:
>> The X-Powers AXP20X and AXP22X PMICs can have a battery as power supply.
>>
>> This patch adds the DT binding documentation for the battery power
>> supply which gets various data from the PMIC, such as the battery status
>> (charging, discharging, full, dead), current max limit, current current,
>> battery capacity (in percentage), voltage max and min limits, current
>> voltage and battery capacity (in Ah).
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> ---
>>  .../bindings/power/supply/axp20x_battery.txt       | 27 ++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
>> new file mode 100644
>> index 0000000..5489d0d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
>> @@ -0,0 +1,27 @@
>> +AXP20x and AXP22x battery power supply
>> +
>> +Required Properties:
>> + - compatible, one of:
>> +			"x-powers,axp209-battery-power-supply"
>> +			"x-powers,axp221-battery-power-supply"
>> + - io-channels: phandles to battery voltage, charge and discharge
>> + currents ADC channels
>> + - io-channel-names = "batt_v", "batt_chrg_i", "batt_dischrg_i";
>> +
>> +This node is a subnode of the axp20x/axp22x PMIC.
>> +
>> +The AXP20X and AXP22X can read the battery voltage, charge and discharge
>> +currents of the battery by reading ADC channels from the AXP20X/AXP22X
>> +ADC.
>> +
>> +Example:
>> +
>> +&axp209 {
>> +	battery_power_supply: battery_power_supply {
> 
> Humm, I guess you power-supply is not sufficient, so 
> 'battery-power-supply' and similar for ac.
> 
>> +		compatible = "x-powers,axp209-battery-power-supply";
>> +		io-channels = <&axp209_adc 7>, <&axp209_adc 8>,
>> +			<&axp209_adc 9>;
>> +		io-channel-names = "batt_v", "batt_chrg_i",
>> +			"batt_dischrg_i";
Is this stuff fixed for the device?
>> +	}
>> +};
>> -- 
>> 2.9.3
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
