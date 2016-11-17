From: pankaj.dubey@samsung.com (pankaj.dubey)
Date: Thu, 17 Nov 2016 07:47:18 +0530
Subject: [PATCH 2/6] dt-bindings: clk: max8997: Add DT binding
 documentation
In-Reply-To: <20161114161546.oitvons6tvlazgsb@rob-hp-laptop>
References: <1478513376-14307-1-git-send-email-pankaj.dubey@samsung.com>
 <1478513376-14307-3-git-send-email-pankaj.dubey@samsung.com>
 <CGME20161114161550epcas1p3a06490b915cff2dffc5af8df54cd6561@epcas1p3.samsung.com>
 <20161114161546.oitvons6tvlazgsb@rob-hp-laptop>
Message-ID: <873e0495-cc2f-6bef-4a37-a8b9999846d6@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Monday 14 November 2016 09:45 PM, Rob Herring wrote:
> On Mon, Nov 07, 2016 at 03:39:32PM +0530, Pankaj Dubey wrote:
>> Add Device Tree binding documentation for the clocks
>> outputs in the Maxim-8997 Power Management IC.
>>
>> CC: Michael Turquette <mturquette@baylibre.com>
>> CC: Rob Herring <robh+dt@kernel.org>
>> CC: devicetree at vger.kernel.org
>> CC: linux-clk at vger.kernel.org
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>  .../devicetree/bindings/clock/maxim,max8997.txt    | 44 ++++++++++++++++++++++
>>  .../bindings/regulator/max8997-regulator.txt       |  3 ++
>>  2 files changed, 47 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/maxim,max8997.txt
>>
>> diff --git a/Documentation/devicetree/bindings/clock/maxim,max8997.txt b/Documentation/devicetree/bindings/clock/maxim,max8997.txt
>> new file mode 100644
>> index 0000000..d2e2a74
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/maxim,max8997.txt
>> @@ -0,0 +1,44 @@
>> +Binding for Maxim MAX8997 32k clock generator block
>> +
>> +This is a part of device tree bindings of MAX8997 multi-function device.
>> +More information can be found in bindings/regulator/max8997-regulator.txt file.
>> +
>> +The MAX8997 contains two 32.768khz clock outputs that can be controlled
>> +(gated/ungated) over I2C.
>> +
>> +Following properties should be presend in main device node of the MFD chip.
>> +
>> +Required properties:
>> +
>> +- #clock-cells: from common clock binding; shall be set to 1.
>> +
>> +Optional properties:
>> +- clock-output-names: From common clock binding.
>> +
>> +Each clock is assigned an identifier and client nodes can use this identifier
>> +to specify the clock which they consume. Following indices are allowed:
>> +    - 0: 32khz_ap clock,
>> +    - 1: 32khz_cp clock,
>> +
>> +Clocks are defined as preprocessor macros in dt-bindings/clock/maxim,max8997.h
>> +header and can be used in device tree sources.
>> +
>> +Example: Node of the MFD chip
>> +
>> +	max8997: max8997_pmic at 66 {
> 
> pmic at 66 {
> 
> With that:
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
> 

Thanks for review and ack.
With above mentioned change I will post v2 soon.

Thanks,
Pankaj Dubey
