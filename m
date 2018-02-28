From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 28 Feb 2018 16:55:50 +0000
Subject: [PATCH] ACPI/IORT: Remove obsolete
 ACPI_IORT_SMMU_V3_CAVIUM_CN99XX define
In-Reply-To: <20180228165305.GA14610@e107981-ln.cambridge.arm.com>
References: <20180228162424.13636-1-lorenzo.pieralisi@arm.com>
 <e6cbbf2a-738c-a77e-efa1-a38a5602ae1c@arm.com>
 <20180228165305.GA14610@e107981-ln.cambridge.arm.com>
Message-ID: <35249df2-23a4-7406-e849-6e2a5955290b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/02/18 16:53, Lorenzo Pieralisi wrote:
> On Wed, Feb 28, 2018 at 04:35:17PM +0000, Robin Murphy wrote:
>> Hi Lorenzo,
>>
>> On 28/02/18 16:24, Lorenzo Pieralisi wrote:
>>> To defeat ACPICA<->kernel merge order dependencies a preprocessor define
>>> value was introduced in the IORT compilation unit according to IORT
>>> revision C, IORT_SMMU_V3_CAVIUM_CN99XX, so that even if the value was
>>> not defined in ACPICA headers the IORT kernel layer would still be able
>>> to function and use it.
>>>
>>> Since commit 0c2021c047ba ("ACPICA: IORT: Update SMMU models for
>>> revision C") finally added the define in ACPICA headers, as required by
>>> ACPICA IORT support, the preprocessor definition in the IORT kernel
>>> compilation unit has become obsolete and can be removed.
>>
>> Can the version check around iort_get_id_mapping_index() go as well?
> 
> https://marc.info/?l=linux-acpi&m=151817852003174&w=2
> 
> Gone :) (just did two patches since they were part of different
> changes), I will batch them up and send them in a pull request for
> v4.17.

Ah, cool - I hadn't see that one go by.

For this one (and the other as well if you like):

Acked-by: Robin Murphy <robin.murphy@arm.com>

Thanks,
Robin.
