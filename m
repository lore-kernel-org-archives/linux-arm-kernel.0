From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 19 Sep 2018 21:41:50 +0300
Subject: [PATCH v3] arm64: dts: ti: k3-am65: Change #address-cells and
 #size-cells of interconnect to 2
In-Reply-To: <20180905134037.szkh3wnugrtnrrfh@kahuna>
References: <20180905111738.8280-1-kishon@ti.com>
 <20180905134037.szkh3wnugrtnrrfh@kahuna>
Message-ID: <ab5fa0c0-8b45-fcaf-baaf-1f948328d9ed@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/18 16:40, Nishanth Menon wrote:
> On 11:17-20180905, Kishon Vijay Abraham I wrote:
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
>> Fixes: ea47eed33a3fe3d919 ("arm64: dts: ti: Add Support for AM654 SoC")
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Acked-by: Tony Lindgren <tony@atomide.com>
>> Acked-by: Vignesh R <vigneshr@ti.com>
>> ---
>> Changes from v2:
>> Added Fixes tag.
> 
> Thanks.
> Acked-by: Nishanth Menon <nm@ti.com>
> 
> Tero: Could we take this for v4.20 ? While this is a bug fix, I think
> it might be better in v4.20 window since it will help provide a clean merge
> of follow on nodes.
> 

Yes, queuing up for 4.20, thanks.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
