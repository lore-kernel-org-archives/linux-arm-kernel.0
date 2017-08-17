From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 17 Aug 2017 08:27:19 +0200
Subject: [PATCHv2 1/3] dt: xilinx: zynqmp: Add bindings for PM firmware
In-Reply-To: <2c2ffced-bc32-1eb4-aabe-ad6386076267@arm.com>
References: <cover.1502886277.git.michal.simek@xilinx.com>
 <2935be9896d54020720919e7dab7c2f86bdc83a3.1502886277.git.michal.simek@xilinx.com>
 <2c2ffced-bc32-1eb4-aabe-ad6386076267@arm.com>
Message-ID: <78b2afc0-a63a-1c57-88db-757fce170522@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.8.2017 17:45, Sudeep Holla wrote:
> 
> 
> On 16/08/17 13:24, Michal Simek wrote:
>> From: Soren Brinkmann <soren.brinkmann@xilinx.com>
>>
>> Document the DT bindings for the Zynq UltraScale+ PM Firmware.
>>
>> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> Changes in v2:
>> - Move to bindings/firmware and also add it to firmware node
>>   Reported-by Rob
>>
>>  .../bindings/firmware/xlnx,zynqmp-pm.txt           | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/firmware/xlnx,zynqmp-pm.txt
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/xlnx,zynqmp-pm.txt b/Documentation/devicetree/bindings/firmware/xlnx,zynqmp-pm.txt
>> new file mode 100644
>> index 000000000000..7de0c82758b3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/firmware/xlnx,zynqmp-pm.txt
>> @@ -0,0 +1,22 @@
>> +Xilinx Zynq MPSoC Firmware Device Tree Bindings
>> +
>> +The zynqmp-pm node describes the interface to platform firmware.
>> +
>> +Required properties:
>> + - compatible:	Must contain:  "xlnx,zynqmp-pm"
>> + - method:	The method of calling the PM-API firmware layer.
>> +		Permitted values are:
>> +		 - "smc" : To be used in configurations without a hypervisor
>> +		 - "hvc" : To be used when hypervisor is present
>> + - interrupts:	Interrupt specifier
> 
> What exactly is this interrupt ? I see it's not SGI, so if it's SPI,
> where does this originate from ? How is that dealt ?
> 

Please look at my response to Mark for more details.

Thanks,
Michal
