From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 26 Oct 2015 13:47:07 +0100
Subject: [PATCH v4] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
In-Reply-To: <8520D5D51A55D047800579B09414719801692D8E@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1445066538-24638-1-git-send-email-bharatku@xilinx.com>
 <5705956.6YyKSO4LdH@wuerfel>
 <8520D5D51A55D047800579B09414719801692D8E@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <562E20CB.4020401@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/26/2015 11:26 AM, Bharat Kumar Gogada wrote:
>>> +       device_type = "pci";
>>> +       interrupt-parent = <&gic>;
>>> +       interrupts = < 0 118 4
>>> +                      0 116 4
>>> +                      0 115 4          // MSI_1 [63...32]
>>> +                      0 114 4 >;       // MSI_0 [31...0]
>>
>> Better write these as tuples:
>>
>> 	interrupts = <0 118 4>, <0 116 4>, <0 115 4>, <0 114 4>;
>>
>> And maybe reverse the order? It looks that might be what the soc
>> integration person had in mind.
>>
>> Also, what is interrupt <0 117 4>? Is that connected here as well?
>> Better list it as well then, even if you don't use it.
>>
> We have it but not using it, we will list it.
> 
>>> +       interrupt-map-mask = <0x0 0x0 0x0 0x7>;
>>> +       interrupt-map = <0x0 0x0 0x0 0x1 &pcie_intc 0x1
>>> +                        0x0 0x0 0x0 0x2 &pcie_intc 0x2
>>> +                        0x0 0x0 0x0 0x3 &pcie_intc 0x3
>>> +                        0x0 0x0 0x0 0x4 &pcie_intc 0x4>;
>>
>>> +       msi-parent = <&nwl_pcie>;
>>> +       reg = <0x0 0xfd0e0000 0x1000
>>> +              0x0 0xfd480000 0x1000
>>> +              0x0 0xE0000000 0x1000000>;
>>
>> Same grouping for reg and interrupt-map as above for interrupts.
> 
> Grouping reg and interrupt-map as tuples will make lengthy line and reduces readability, is it compulsory ?


FYI: Just this.
      reg = <0x0 0xfd0e0000 0x1000>,
            <0x0 0xfd480000 0x1000>,
            <0x0 0xe0000000 0x1000000>;

Also please make sure that you are using the same case for addresses.
That 0xE0000000 case above.

Thanks,
Michal
