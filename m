From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 8 Jun 2016 17:48:15 +0100
Subject: [PATCH v2] of: iommu: make of_iommu_init() postcore_initcall_sync
In-Reply-To: <CAL_JsqL23AohbYhbQZyT-PRPKujttTZNNh1qdoQXv8BwyYq+mg@mail.gmail.com>
References: <1464761175-22677-1-git-send-email-wangkefeng.wang@huawei.com>
 <CAL_JsqL23AohbYhbQZyT-PRPKujttTZNNh1qdoQXv8BwyYq+mg@mail.gmail.com>
Message-ID: <57584C4F.6050108@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/16 16:44, Rob Herring wrote:
> On Wed, Jun 1, 2016 at 1:06 AM, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>> The of_iommu_init() is called multiple times by arch code,
>> make it postcore_initcall_sync, then we can drop relevant
>> calls fully.
>>
>> Note, the IOMMUs should have a chance to perform some basic
>> initialisation before we start adding masters to them. So
>> postcore_initcall_sync is good choice, it ensures of_iommu_init()
>> called before of_platform_populate.
>
> What ever happened to doing deferred probe for IOMMUs?

Sricharan has been trying to resurrect it recently[1], although the fact 
that we're starting to need more or less the same thing for certain 
interrupt controllers as well (and I'm not sure how immune ACPI IORT is 
to the problem) suggests a more general rethink might be in order. I've 
got a big TODO item hanging over me on that one...

Robin.

[1]:http://thread.gmane.org/gmane.linux.kernel.iommu/13243

>
> Rob
>
