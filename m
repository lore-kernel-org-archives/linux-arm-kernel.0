From: sunil.kovvuri@gmail.com (Sunil Kovvuri)
Date: Tue, 11 Apr 2017 22:09:39 +0530
Subject: [RFC PATCH 2/7] iommu/arm-smmu-v3: Do resource size checks based
 on smmu option PAGE0_REGS_ONLY
In-Reply-To: <802c0a38-f5a6-e584-5795-42d8d3fd7603@arm.com>
References: <1491921765-29475-1-git-send-email-linucherian@gmail.com>
 <1491921765-29475-3-git-send-email-linucherian@gmail.com>
 <802c0a38-f5a6-e584-5795-42d8d3fd7603@arm.com>
Message-ID: <CA+sq2CfN0QOrcT9Nv3wkf-NwWwV4uO46UmDaObzmhs7W-407qA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 11, 2017 at 9:13 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 11/04/17 15:42, linucherian at gmail.com wrote:
>> From: Linu Cherian <linu.cherian@cavium.com>
>>
>> With implementations supporting only page 0 of register space,
>> resource size can be 64k as well and hence perform size checks
>> based on smmu option PAGE0_REGS_ONLY.
>
> What harm comes of mapping page 1 if we don't access it?
>
> Robin.
>

There are multiple SMMUs on the silicon and CSRs of each SMMU are
64K apart. Hence can't map page-1 even though it's not accessed.

Thanks,
Sunil.
