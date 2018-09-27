From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 27 Sep 2018 09:10:23 +0100
Subject: [PATCH] iommu: rockchip: Drop verbose prints in the interrupt
 handler
In-Reply-To: <ea4d539ecbaf229bef8c0810c6a11cf824339b4b.camel@collabora.com>
References: <20180830222832.16766-1-ezequiel@collabora.com>
 <20180925112930.u5kftmo3vhmdxji4@8bytes.org>
 <ea4d539ecbaf229bef8c0810c6a11cf824339b4b.camel@collabora.com>
Message-ID: <03cdadf4-14e7-8643-81f6-cd2e7d2f3e88@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/09/18 18:31, Ezequiel Garcia wrote:
> On Tue, 2018-09-25 at 13:29 +0200, Joerg Roedel wrote:
>> On Thu, Aug 30, 2018 at 07:28:32PM -0300, Ezequiel Garcia wrote:
>>> Printing verbosely via WARN macros and friends in interrupt handlers
>>> is strongly discouraged. Drop them and use proper ratelimited
>>> prints.
>>>
>>> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
>>> ---
>>>   drivers/iommu/rockchip-iommu.c | 10 ++++++----
>>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> This doesn't apply cleanly to v4.19-rc5, can you please base the patch
>> on that tag, add the Reviewed-by and re-send?
>>
> 
> Well, after looking at the latest code, now I'm wondering why Marc
> changed the WARN_ON with a WARN_ON_ONCE, instead of a less verbose
> ratelimited print.

WARN_ONCE does it exactly once. A rate-limited printk will still spit as 
many messages as you want.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
