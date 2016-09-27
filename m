From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 27 Sep 2016 16:58:28 +0530
Subject: [RFC PATCH 07/11] pci: controller: designware: Add EP mode support
In-Reply-To: <20160923144141.GA24842@rob-hp-laptop>
References: <1473829927-20466-1-git-send-email-kishon@ti.com>
 <1473829927-20466-8-git-send-email-kishon@ti.com>
 <20160923144141.GA24842@rob-hp-laptop>
Message-ID: <57EA57DC.9030304@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 23 September 2016 08:11 PM, Rob Herring wrote:
> On Wed, Sep 14, 2016 at 10:42:03AM +0530, Kishon Vijay Abraham I wrote:
>> Add endpoint mode support to designware driver. This uses the
>> EP Core layer introduced recently to add endpoint mode support.
>> *Any* function driver can now use this designware device
>> to achieve the EP functionality.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../devicetree/bindings/pci/designware-pcie.txt    |   26 ++-
>>  drivers/pci/controller/Kconfig                     |    5 +
>>  drivers/pci/controller/Makefile                    |    1 +
>>  drivers/pci/controller/pcie-designware-ep.c        |  228 ++++++++++++++++++++
>>  drivers/pci/controller/pcie-designware.c           |   30 +++
>>  drivers/pci/controller/pcie-designware.h           |   45 ++++
>>  6 files changed, 324 insertions(+), 11 deletions(-)
>>  create mode 100644 drivers/pci/controller/pcie-designware-ep.c
>>
>> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> index 6c5322c..bb0b789 100644
>> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> @@ -6,23 +6,27 @@ Required properties:
>>  - reg-names: Must be "config" for the PCIe configuration space.
>>      (The old way of getting the configuration address space from "ranges"
>>      is deprecated and should be avoided.)
>> -- #address-cells: set to <3>
>> -- #size-cells: set to <2>
>> -- device_type: set to "pci"
>> -- ranges: ranges for the PCI memory and I/O regions
>> -- #interrupt-cells: set to <1>
>> -- interrupt-map-mask and interrupt-map: standard PCI properties
>> -	to define the mapping of the PCIe interface to interrupt
>> +- #address-cells (only for host mode): set to <3>
>> +- #size-cells (only for host mode): set to <2>
>> +- device_type (only for host mode): set to "pci"
>> +- ranges (only for host mode): ranges for the PCI memory and I/O regions
>> +- num-ib-windows (only for EP mode): number of inbound address translation
>> +	windows
>> +- num-ob-windows (only for EP mode): number of outbound address translation
>> +	windows
>> +- #interrupt-cells (only for host mode): set to <1>
>> +- interrupt-map-mask and interrupt-map (only for host mode): standard PCI
>> +	properties to define the mapping of the PCIe interface to interrupt
> 
> It may be clearer to just document EP mode in a separate section even if 
> there's some duplication of properties. Other standard PCI binding 
> properties probably also don't apply.

right, will change this accordingly.

Thanks
Kishon
