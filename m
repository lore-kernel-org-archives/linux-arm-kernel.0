From: vigneshr@ti.com (Vignesh R)
Date: Tue, 4 Sep 2018 20:52:40 +0530
Subject: [PATCH v2] arm64: dts: ti: k3-am65: Change #address-cells and
 #size-cells of interconnect to 2
In-Reply-To: <20180904134142.npoxfimfsllmxdwb@akan>
References: <20180903095235.13853-1-kishon@ti.com>
 <20180904134142.npoxfimfsllmxdwb@akan>
Message-ID: <921e9705-1ac4-29fa-61bb-e6f4261b125e@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 04 September 2018 07:11 PM, Menon, Nishanth wrote:
> On 15:22-20180903, Kishon Vijay Abraham I wrote:
> 
>> AM65 has two PCIe controllers and each PCIe controller has '2' address
>> spaces one within the 4GB address space of the SoC and the other above
>> the 4GB address space of the SoC (cbass_main) in addition to the
>> register space. The size of the address space above the 4GB SoC address
>> space is 4GB. These address ranges will be used by CPU/DMA to access
>> the PCIe address space. In order to represent the address space above
>> the 4GB SoC address space and to represent the size of this address
>> space as 4GB, change address-cells and size-cells of interconnect to 2.
>>
>> Since OSPI has similar need in MCU Domain Memory Map, change
>> address-cells and size-cells of cbass_mcu interconnect also to 2.
>>
> 
> Please add Fixes
> 
> Vignesh, Sekhar, Tony,
> 
> Do we agree this is the right way to go forward? if yes, please
> ack.
> 
>

LGTM, thanks kishon!

Acked-by: Vignesh R <vigneshr@ti.com>



-- 
Regards
Vignesh
