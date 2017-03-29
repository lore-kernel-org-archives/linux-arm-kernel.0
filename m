From: niklas.cassel@axis.com (Niklas Cassel)
Date: Wed, 29 Mar 2017 15:13:36 +0200
Subject: [GIT PULL] PCI: Support for configurable PCI endpoint
In-Reply-To: <6868a887-a270-96d6-0600-af2a1af383a8@ti.com>
References: <20170327094520.3129-1-kishon@ti.com>
 <0cfe5acf-332c-00c9-e5d5-1403c4e80ebe@axis.com>
 <99ae043b-35fd-0723-c8a7-e2625a862c6d@ti.com>
 <6868a887-a270-96d6-0600-af2a1af383a8@ti.com>
Message-ID: <c506cc2c-b877-5a12-33a9-4fafa307ff89@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/29/2017 02:36 PM, Kishon Vijay Abraham I wrote:
(snip)
>>>
>>> FWIW:
>>> I've tested Kishon's tag pci-endpoint-for-4.12
>>> and PCIe on artpec6 SoC is still working fine.
>>
>> Thanks for testing it.
>>>
>>> I also included the DRA7xx PCIe driver in my
>>> kernel so that pcie-designware-ep.c gets built.
>>>
>>> My only worry is that the code in pcie-designware-ep.c
>>> is not compile tested if DRA7xx is not selected
>>> (as it is the only driver using PCIE_DW_EP at
>>> the moment).
>>
>> yeah, we should plan to include COMPILE_TEST in all pci drivers but I guess
>> there is some problem with non-ARM builds [1]. As Bjorn mentioned in the
>> thread, we could add #ifdef ARM and then include COMPILE_TEST.
> 
> I think I misunderstood your concern. yeah, there is no direct way to compile
> pcie-designware-ep.c without selecting DRA7xx.

There is no way to compile pcie-designware-host.c + pcie-designware.c
without selecting a driver that selects PCIE_DW_HOST,
so I guess the same "problem" applies there.

As long as kbuild builds PCI_DRA7XX_EP (and any driver that selects
PCIE_DW_HOST), we should be fine.
