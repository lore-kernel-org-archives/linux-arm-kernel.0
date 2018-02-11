From: guohanjun@huawei.com (Hanjun Guo)
Date: Sun, 11 Feb 2018 10:06:02 +0800
Subject: [PATCH] ACPI/IORT: Remove temporary iort_get_id_mapping_index()
 ACPICA guard
In-Reply-To: <20180209121510.9015-1-lorenzo.pieralisi@arm.com>
References: <20180209121510.9015-1-lorenzo.pieralisi@arm.com>
Message-ID: <da3331ec-686d-5809-65ce-9c562682b4fc@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018/2/9 20:15, Lorenzo Pieralisi wrote:
> In IORT issue C SMMUv3 IORT nodes gained an additional field (DeviceID
> mapping index) so that the SMMUv3 can describe its MSI interrupts.
> 
> Referring to it in the kernel requires ACPICA changes and in order
> to prevent kernel<->ACPICA dependencies kernel code depending on the
> SMMUv3 DeviceID mapping index field was guarded with an ACPICA version
> conditional.
> 
> ACPICA changes introducing DeviceID mapping index in the IORT structs
> were integrated in the kernel with:
> 
> commit 4c106aa411ee ("ACPICA: iasl: Add SMMUv3 device ID mapping index
> support")
> 
> so the temporary ACPICA guard has become stale and can be removed.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>

Thanks for doing this,

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
