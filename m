From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 14 Aug 2017 15:47:15 +0200
Subject: [PATCH 1/3] dt: xilinx: zynqmp: Add bindings for PM firmware
In-Reply-To: <20170811135453.GU12347@toto>
References: <cover.1501854302.git.michal.simek@xilinx.com>
 <8c27b7eec6cc00d37dfe9b3998212ce9c9c27a31.1501854302.git.michal.simek@xilinx.com>
 <20170810191056.ur5b3zdrcgmb6sim@rob-hp-laptop>
 <4e5d9f8c-9e87-bdcd-388a-aab3c32415e8@xilinx.com>
 <20170811135453.GU12347@toto>
Message-ID: <5d2e3a5e-6060-ff13-a065-c4b6be37e4c9@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.8.2017 15:54, Edgar E. Iglesias wrote:
> On Fri, Aug 11, 2017 at 02:58:03PM +0200, Michal Simek wrote:
>> Hi Rob, +Edgar,
>>
>> On 10.8.2017 21:10, Rob Herring wrote:
>>> On Fri, Aug 04, 2017 at 03:45:30PM +0200, Michal Simek wrote:
>>>> From: Soren Brinkmann <soren.brinkmann@xilinx.com>
>>>>
>>>> Document the DT bindings for the Zynq UltraScale+ PM Firmware.
>>>>
>>>> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>> ---
>>>>
>>>>  .../devicetree/bindings/soc/xilinx/xlnx,zynqmp-pm.txt | 19 +++++++++++++++++++
>>>
>>> bindings/firmware/
>>
>> will move.
>>
>>>
>>>>  1 file changed, 19 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/soc/xilinx/xlnx,zynqmp-pm.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/soc/xilinx/xlnx,zynqmp-pm.txt b/Documentation/devicetree/bindings/soc/xilinx/xlnx,zynqmp-pm.txt
>>>> new file mode 100644
>>>> index 000000000000..222a18ce07fc
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/soc/xilinx/xlnx,zynqmp-pm.txt
>>>> @@ -0,0 +1,19 @@
>>>> +Xilinx Zynq MPSoC Firmware Device Tree Bindings
>>>> +
>>>> +The zynqmp-pm node describes the interface to platform firmware.
>>>
>>> Please define this should be under /firmware node.
>>>
>>>> +Required properties:
>>>> + - compatible:	Must contain:  "xlnx,zynqmp-pm"
>>>> + - method:	The method of calling the PM-API firmware layer.
>>>> +		Permitted values are:
>>>> +		 - "smc" : To be used in configurations without a hypervisor
>>>> +		 - "hvc" : To be used when hypervisor is present
>>>
>>> Do you really use both?
>>>
>>
>> SMCs definitely yes.
>>
>> Interface was designed in that way and I don't know if people are using
>> it or not.
>>
>> Not sure if Xen is blocking SMCs. I know we have discussed it but not
>> sure if this is enabled by default or only for certain configurations.
>> Also not sure if xen contains handler for hvc.
>> Edgar: Do you know?
> 
> We have patches for Xen that implement a power-management mediator.
> That implementation handles PM calls over both SMC and HVC insns.
> Patches are on the Xen mailing list.
> 
> Other hypervisors may work differently.
> 
> I think we should support both but I don't have a strong opinion on it.

Rob: Are you ok with having it there?

Thanks,
Michal
