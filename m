From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 17 Aug 2017 08:26:34 +0200
Subject: [PATCHv2 1/3] dt: xilinx: zynqmp: Add bindings for PM firmware
In-Reply-To: <20170816160046.GB12389@leverpostej>
References: <cover.1502886277.git.michal.simek@xilinx.com>
 <2935be9896d54020720919e7dab7c2f86bdc83a3.1502886277.git.michal.simek@xilinx.com>
 <20170816160046.GB12389@leverpostej>
Message-ID: <04d8618e-4f39-9caf-95cb-60af35dba662@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.8.2017 18:00, Mark Rutland wrote:
> On Wed, Aug 16, 2017 at 02:24:56PM +0200, Michal Simek wrote:
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
> 
> Is there any documentation for this? I appreciate that the answer
> might be "no".

We have pm documentation somewhere but not sure if this firmware
interface is the part of it. Let me ask around and see what I can find out.

> 
>> +Required properties:
>> + - compatible:	Must contain:  "xlnx,zynqmp-pm"
>> + - method:	The method of calling the PM-API firmware layer.
>> +		Permitted values are:
>> +		 - "smc" : To be used in configurations without a hypervisor
>> +		 - "hvc" : To be used when hypervisor is present
>> + - interrupts:	Interrupt specifier
> 
> For what, exactly?
> 
> Is this an interrupt for FW to signal the OS somehow?
> 
> If so, is it an SGI?

This is SPI. There is a dedicated hardware on the chip for communication
with APU.

https://www.xilinx.com/support/documentation/user_guides/ug1085-zynq-ultrascale-trm.pdf
page 275

Anyway I don't need this for this driver that's why I will remove it.

Thanks,
Michal
