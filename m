From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 16 Feb 2017 14:03:57 +0530
Subject: [PATCH 30/37] dt-bindings: PCI: dra7xx: Add dt bindings to enable
 legacy mode
In-Reply-To: <20170118214603.qnewy3sm6sgw7lbg@rob-hp-laptop>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-31-git-send-email-kishon@ti.com>
 <20170118214603.qnewy3sm6sgw7lbg@rob-hp-laptop>
Message-ID: <58A563F5.5040504@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 19 January 2017 03:16 AM, Rob Herring wrote:
> On Thu, Jan 12, 2017 at 03:56:19PM +0530, Kishon Vijay Abraham I wrote:
>> Update device tree binding documentation of TI's dra7xx PCI
>> controller to include property for enabling legacy mode.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  Documentation/devicetree/bindings/pci/ti-pci.txt |    4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
>> index 62f5f59..ed85e8e 100644
>> --- a/Documentation/devicetree/bindings/pci/ti-pci.txt
>> +++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
>> @@ -39,6 +39,10 @@ DEVICE MODE
>>   - interrupts : one interrupt entries must be specified for main interrupt.
>>   - num-ib-windows : number of inbound address translation windows
>>   - num-ob-windows : number of outbound address translation windows
>> + - syscon-legacy-mode: phandle to the syscon dt node. The 1st argument should
>> +		       contain the register offset within syscon and the 2nd
>> +		       argument should contain the bit field for setting the
>> +		       legacy mode
> 
> What's legacy mode?

It's the name of the bit-field defined in TRM used to add workaround for errata
id i870 (See [PATCH 29/37] PCI: dwc: dra7xx: Workaround for errata id i870 of
this series). I'm not sure what it does internally.

Thanks
Kishon
