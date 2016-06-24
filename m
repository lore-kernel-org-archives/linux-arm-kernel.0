From: robh+dt@kernel.org (Rob Herring)
Date: Fri, 24 Jun 2016 15:36:27 -0500
Subject: [PATCH v5 00/18] Cleanup for populate default bus
In-Reply-To: <20160615140232.GN26566@8bytes.org>
References: <1464763991-26634-1-git-send-email-wangkefeng.wang@huawei.com>
 <CAL_JsqKesg9=Gc83ULcpGwWU_C3BO3o02fUcur=RO__BgLPpug@mail.gmail.com>
 <20160615140232.GN26566@8bytes.org>
Message-ID: <CAL_JsqLmrpdGYar39xA_aAVPG_s_20LsnfVvS5Ms2SA1HES+Gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 9:02 AM, Joerg Roedel <joro@8bytes.org> wrote:
> On Wed, Jun 08, 2016 at 10:42:50AM -0500, Rob Herring wrote:
>> +Joerg, Will
>>
>> On Wed, Jun 1, 2016 at 1:52 AM, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>> > This cleanup patchset cantains two parts.
>> >
>> > Firstly, introduce a new way to populate the default bus, then, we can
>> > drop unnecessary calls from the arch code, and do the same thing for
>> > of_iommu_init() in [1].
>> >
>> > Secondly, use helper of_platform_default_populate() in linux/of_platform
>> > when possible, instead of calling of_platform_populate() with default
>> > match table, After that, it is possible for driver code build as a module,
>> > and no need to export of_default_bus_match_table anymore.
>> >
>> > This patchset is based on Linux 4.7-rc1, and only test in arm/arm64 qemu
>> > with defconfig.
>>
>> This series doesn't apply for me as it appears you had "of: iommu:
>> make of_iommu_init() postcore_initcall_sync" in your tree. Either we
>> need to phase these out over 2 releases or someone needs to take them
>> all (or we leave the minor conflicts for Linus).
>
> Feel free to take the mentioned patch through your tree with my
>
> Acked-by: Joerg Roedel <jroedel@suse.de>

Thanks.

I've applied this series now.

Rob
