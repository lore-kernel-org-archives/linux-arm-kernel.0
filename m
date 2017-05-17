From: john.garry@huawei.com (John Garry)
Date: Wed, 17 May 2017 09:05:20 +0100
Subject: [RFC v1 7/7] iommu/arm-smmu-v3: Enable ACPI based HiSilicon
 erratum 161010801
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA838350A62@FRAEML521-MBX.china.huawei.com>
References: <20170513094731.3676-1-shameerali.kolothum.thodi@huawei.com>
 <20170513094731.3676-8-shameerali.kolothum.thodi@huawei.com>
 <a4e62cb2-9eb6-99a0-3443-df77ae9af8f8@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA838350A62@FRAEML521-MBX.china.huawei.com>
Message-ID: <2271be83-fd92-a3d9-ce61-a5471cde51be@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/05/2017 15:03, Shameerali Kolothum Thodi wrote:
>> > Lorenzo made a point that it might be relatively straightforward to just
>> > follow the IORT mapping for the SMMU through to the ITS MADT entry and
>> > pull the ITS geometry out of that. It would certainly be nicer to have
>> > such a helper abstracted away in the IORT code than have to go parsing
>> > vendor-specific tables directly in the SMMU driver. I reckon it might be
>> > worth taking that idea a bit further to see how it looks.
> Ok. John has already mentioned this idea in our off-list discussion and we
> have one implementation where we go through the IORT node ID mappings
> array to find out the associated IORT ITS  node. It then iterates over the ACPI
> MADT  GIC ITS table entries, , looking for a match for the GIC ITS id, and
> retrieves the base address of the matching ITS.
>
> But as you said, it requires some helper from the IORT code , otherwise we
> will end up adding all the ACPI table parse code in SMMUv3. We will take
> another look at this.
>
> Thanks,
> Shameer
>

It could also be worth considering hard-coding the reserved address in 
the SMMUv3 driver for this model. This would not involve (more) reliance 
on CSRT or IORT driver. However, note that hip07 has multiple SMMUs, and 
we only need to enable the quirk for the SMMU in front the PCIe host 
controller.

John

BTW, FYI, hi161x is alias for hip07/06
