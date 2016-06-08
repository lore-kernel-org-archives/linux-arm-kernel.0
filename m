From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 8 Jun 2016 10:44:31 -0500
Subject: [PATCH v2] of: iommu: make of_iommu_init() postcore_initcall_sync
In-Reply-To: <1464761175-22677-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1464761175-22677-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <CAL_JsqL23AohbYhbQZyT-PRPKujttTZNNh1qdoQXv8BwyYq+mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 1, 2016 at 1:06 AM, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> The of_iommu_init() is called multiple times by arch code,
> make it postcore_initcall_sync, then we can drop relevant
> calls fully.
>
> Note, the IOMMUs should have a chance to perform some basic
> initialisation before we start adding masters to them. So
> postcore_initcall_sync is good choice, it ensures of_iommu_init()
> called before of_platform_populate.

What ever happened to doing deferred probe for IOMMUs?

Rob
