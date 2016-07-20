From: mirza.krak@gmail.com (Mirza Krak)
Date: Wed, 20 Jul 2016 21:28:05 +0200
Subject: [RFC 3/6] dt/bindings: Add bindings for Tegra20/30 NOR bus driver
In-Reply-To: <20160720124408.GA19113@rob-hp-laptop>
References: <1468935397-11926-1-git-send-email-mirza.krak@gmail.com>
 <1468935397-11926-4-git-send-email-mirza.krak@gmail.com>
 <20160720124408.GA19113@rob-hp-laptop>
Message-ID: <CALw8SCXFexogJn3BwrZm63yEL0rtTpYsYYb0O9D_ibhginVLqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-07-20 14:44 GMT+02:00 Rob Herring <robh@kernel.org>:
> On Tue, Jul 19, 2016 at 03:36:34PM +0200, Mirza Krak wrote:
>> From: Mirza Krak <mirza.krak@gmail.com>
>>
>> Document the devicetree bindings for NOR bus driver found on Tegra20 and
>> Tegra30 SOCs
>>
>> Signed-off-by: Mirza Krak <mirza.krak@gmail.com>
>> ---
>>  .../devicetree/bindings/bus/nvidia,tegra20-nor.txt | 73 ++++++++++++++++++++++
>>  1 file changed, 73 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/bus/nvidia,tegra20-nor.txt
>>
>> diff --git a/Documentation/devicetree/bindings/bus/nvidia,tegra20-nor.txt b/Documentation/devicetree/bindings/bus/nvidia,tegra20-nor.txt
>> new file mode 100644
>> index 0000000..9ee4a66
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/bus/nvidia,tegra20-nor.txt
>> @@ -0,0 +1,73 @@
>> +Device tree bindings for NVIDIA Tegra20/30 NOR Bus
>> +
>> +The NOR controller supports a number of memory types, including synchronous NOR,
>> +asynchronous NOR, and other flash memories with similar interfaces, such as
>> +MuxOneNAND. One could also connect high speed devices like FPGAs, DSPs,
>> +CAN chips, Wi-Fi chips etc.
>> +
>> +The actual devices are instantiated from the child nodes of a NOR node.
>> +
>> +Required properties:
>> +
>> + - compatible: should be "nvidia,tegra20-nor", "nvidia,tegra30-nor"
>> + - reg: Should contain NOR controller registers location and length.
>> + - clocks: Must contain one entry, for the module clock.
>> +   See ../clocks/clock-bindings.txt for details.
>> + - resets : Must contain an entry for each entry in reset-names.
>> +   See ../reset/reset.txt for details.
>> + - reset-names : Must include the following entries:
>> +  - nor
>> + - #address-cells: Must be set to 2 to allow memory address translation
>> + - #size-cells:      Must be set to 1 to allow CS address passing
>> + - ranges: Must be set up to reflect the memory layout with four integer
>> +             values for each chip-select line in use.
>> + - nvidia,config: This property represents the SNOR_CONFIG_0 register.
>> +
>> +Note that the NOR controller does not have any internal chip-select address
>> +decoding and if you want to access multiple devices external chip-select
>> +decoding must be provided.
>
> Then what are the 2 chip selects in ranges?
>
> Rob

Those two chip selects are actually a representation of a external
decoding logic based on what we use on our board. Even though it the
NOR controller only supports one single chip select I wanted to give
an example on how one could create more chip-selects with an external
logic and what it would look like in the device tree representation.

I realize that the bindings should include above explanation or
something similar.

-- 
Med V?nliga H?lsningar / Best Regards

Mirza Krak
mirza.krak at gmail.com
Mobile: +46730280622
