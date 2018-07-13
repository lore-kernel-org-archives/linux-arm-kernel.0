From: guohanjun@huawei.com (Hanjun Guo)
Date: Fri, 13 Jul 2018 10:22:51 +0800
Subject: [PATCH 1/1] iommu/arm-smmu-v3: prevent any devices access to
 memory without registration
In-Reply-To: <5B4804D6.4050508@huawei.com>
References: <1531387723-3592-1-git-send-email-thunder.leizhen@huawei.com>
 <20180712170120.GC26935@arm.com> <5B4804D6.4050508@huawei.com>
Message-ID: <8067f5d2-b241-d5f2-42f6-466913f04e04@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018/7/13 9:48, Leizhen (ThunderTown) wrote:
> 
> 
> On 2018/7/13 1:01, Will Deacon wrote:
>> On Thu, Jul 12, 2018 at 05:28:43PM +0800, Zhen Lei wrote:
>>> Stream bypass is not security. A malicious device can be hot plugged
>>> without match any drivers, but it can access to any memory. So change to
>>> disable bypass by default.
>>>
>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>> ---
>>>  drivers/iommu/arm-smmu-v3.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Whilst this sounds nice, I *bet* you it will break some systems. In
>> particular, those where the SMMU is described but the toplogical information
>> is either incorrect or incomplete.
> 
> Suppose this scene exists, maybe we should consider updating IORT specification,
> to indicate whether a smmu treats all unregistered devices as stream bypass or not, --- global control
> to indicate whether a single device default use stream bypass or not, --- local control
> that will be more flexible. But we still disable bypass by default.

IORT (or dts) is about the hardware feature, if it's only
about the wrong topological information of devices and
SMMU, I think IORT is not the right place to describe such
information, we need correct that information instead.

Thanks
Hanjun
