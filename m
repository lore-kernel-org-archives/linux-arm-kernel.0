From: guohanjun@huawei.com (Hanjun Guo)
Date: Fri, 30 Dec 2016 18:40:53 +0800
Subject: [PATCH v5 09/14] ACPI: platform: setup MSI domain for ACPI based
 platform device
In-Reply-To: <9aa650ad-a32d-e942-1c6b-b069c8a2b87a@codeaurora.org>
References: <1482384922-21507-1-git-send-email-guohanjun@huawei.com>
 <1482384922-21507-10-git-send-email-guohanjun@huawei.com>
 <CAJZ5v0g4AoU-g4UWZFxLgQ_yfTC7KSBnZ_Ve945d+i58e=GuDQ@mail.gmail.com>
 <585E24FB.9050805@huawei.com>
 <CAJZ5v0itKF-uo7vGxK3+-X4OwBVYPdBw-b8v-8-CTBygpKMGoQ@mail.gmail.com>
 <586072E9.3060609@huawei.com>
 <9aa650ad-a32d-e942-1c6b-b069c8a2b87a@codeaurora.org>
Message-ID: <586639B5.8010705@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/12/29 22:44, Sinan Kaya wrote:
> On 12/25/2016 8:31 PM, Hanjun Guo wrote:
>>> A type->setup() would be somewhat cleaner I think, but then it's more
>>> code.  Whichever works better I guess. :-)
>> Agree, I will demo the type->setup() way and send out the patch for review,
>> also I find one minor issue for the IORT code, will update that also for next
>> version.
> Can you provide details on what the minor issue is with the IORT code?

It's about the mapping of NC (named component) -> SMMU -> ITS, we can
describe it as two ID mappings:
 - NC->SMMU
 - NC->ITS
And the code for now can work perfect for such id mappings, but if we
want to support chained mapping NC  -> SMMU -> ITS, we need to add
extra code which in my [PATCH v5 10/14] ACPI: ARM64: IORT: rework
iort_node_get_id() for NC->SMMU->ITS case, but I just scanned the first
id mapping for now, I think I need to scan all the id mappings (but seems
single id mappings don't need to do that, I will investigate it more).

Thanks
Hanjun
