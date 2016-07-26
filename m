From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 26 Jul 2016 10:24:15 -0600
Subject: [PATCH 3/3] dt-bindings: add Tegra186 BPMP I2C binding
In-Reply-To: <b088284b-e87e-0da5-59a8-0b039b06fcad@nvidia.com>
References: <20160719191442.15439-1-swarren@wwwdotorg.org>
 <20160719191442.15439-3-swarren@wwwdotorg.org>
 <b088284b-e87e-0da5-59a8-0b039b06fcad@nvidia.com>
Message-ID: <30795dd3-99cd-a1b6-d539-c2afbca34d17@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/26/2016 04:03 AM, Jon Hunter wrote:
>
> On 19/07/16 20:14, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> In Tegra186, the BPMP (Boot and Power Management Processor) owns certain
>> HW devices, such as the I2C controller for the power management I2C bus.
>> Software running on other CPUs must perform IPC to the BPMP in order to
>> execute transactions on that I2C bus. This binding describes an I2C bus
>> that is accessed in such a fashion.
>>
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>> ---
>>  .../bindings/i2c/nvidia,tegra186-bpmp-i2c.txt      | 42 ++++++++++++++++++++++
>>  1 file changed, 42 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/i2c/nvidia,tegra186-bpmp-i2c.txt
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/nvidia,tegra186-bpmp-i2c.txt b/Documentation/devicetree/bindings/i2c/nvidia,tegra186-bpmp-i2c.txt
>> new file mode 100644
>> index 000000000000..fecb549bc250
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/i2c/nvidia,tegra186-bpmp-i2c.txt
>> @@ -0,0 +1,42 @@
>> +NVIDIA Tegra186 BPMP I2C controller
>> +
>> +In Tegra186, the BPMP (Boot and Power Management Processor) owns certain HW
>> +devices, such as the I2C controller for the power management I2C bus. Software
>> +running on other CPUs must perform IPC to the BPMP in order to execute
>> +transactions on that I2C bus. This binding describes an I2C bus that is
>> +accessed in such a fashion.
>> +
>> +The BPMP I2C node must be located directly inside the main BPMP node. See
>> +../firmware/nvidia,tegra186-bpmp.txt for details of the BPMP binding.
>> +
>> +This node represents an I2C controller. See ../i2c/i2c.txt for details of the
>> +core I2C binding.
>> +
>> +Required properties:
>> +- compatible:
>> +    Array of strings.
>> +    One of:
>> +    - "nvidia,tegra186-bpmp-i2c".
>> +- #address-cells: Address cells for I2C device address.
>> +    Single-cell integer.
>> +    Must be <1>.
>> +- #size-cells:
>> +    Single-cell integer.
>> +    Must be <0>.
>> +- nvidia,bpmp-bus-id:
>> +    Single-cell integer.
>> +    Indicates the I2C bus number this DT node represent, as defined by the
>> +    BPMP firmware.
>> +
>> +Example:
>> +
>> +/ bpmp {
>
> Is this "/" intentional?

I think I meant to write "/bpmp" (i.e. without the space) to highlight 
where the node is in the overall hierarchy, but admittedly that's 
unusual. Yes, the "/ " should probably simply be removed.

>> +	...
>> +
>> +	bpmp-i2c {
>> +		compatible = "nvidia,tegra186-bpmp-i2c";
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		nvidia,bpmp-bus-id = <5>;
>> +	};
>> +};
>>
>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
>
> Jon
