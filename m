From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 8 Jun 2016 10:42:50 -0500
Subject: [PATCH v5 00/18] Cleanup for populate default bus
In-Reply-To: <1464763991-26634-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1464763991-26634-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <CAL_JsqKesg9=Gc83ULcpGwWU_C3BO3o02fUcur=RO__BgLPpug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Joerg, Will

On Wed, Jun 1, 2016 at 1:52 AM, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> This cleanup patchset cantains two parts.
>
> Firstly, introduce a new way to populate the default bus, then, we can
> drop unnecessary calls from the arch code, and do the same thing for
> of_iommu_init() in [1].
>
> Secondly, use helper of_platform_default_populate() in linux/of_platform
> when possible, instead of calling of_platform_populate() with default
> match table, After that, it is possible for driver code build as a module,
> and no need to export of_default_bus_match_table anymore.
>
> This patchset is based on Linux 4.7-rc1, and only test in arm/arm64 qemu
> with defconfig.

This series doesn't apply for me as it appears you had "of: iommu:
make of_iommu_init() postcore_initcall_sync" in your tree. Either we
need to phase these out over 2 releases or someone needs to take them
all (or we leave the minor conflicts for Linus).

Rob
