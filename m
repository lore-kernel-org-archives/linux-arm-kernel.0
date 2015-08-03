From: vigneshr@ti.com (Vignesh R)
Date: Mon, 3 Aug 2015 10:32:09 +0530
Subject: [RFC PATCH 4/5] ARM: dts: DRA7: Add memory map region entries
 for qspi
In-Reply-To: <20150731181903.GN20873@sirena.org.uk>
References: <1438072876-16338-1-git-send-email-vigneshr@ti.com>
 <1438072876-16338-5-git-send-email-vigneshr@ti.com>
 <20150731181903.GN20873@sirena.org.uk>
Message-ID: <55BEF5D1.1050608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/31/2015 11:49 PM, Mark Brown wrote:
> On Tue, Jul 28, 2015 at 02:11:15PM +0530, Vignesh R wrote:
>> Add qspi memory mapped region entries for DRA7xx based SoCs.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
> 
>>  		qspi: qspi at 47900000 {
>>  			compatible = "ti,am4372-qspi";
>> -			reg = <0x47900000 0x100>;
>> +			reg = <0x47900000 0x100>,
>> +			      <0x30000000 0x3ffffff>;
>> +			reg-names = "qspi_base", "qspi_mmap";
> 
> The DT binding document for the controller needs to be extended to
> document this change in the binding.
> 

DT bindings are already documented at
Documentation/devicetree/bindings/spi/ti_qspi.txt. Did you mean to add
this node as an example in that file?

-- 
Regards
Vignesh
