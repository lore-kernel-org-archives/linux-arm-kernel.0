From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Wed, 23 Jul 2014 11:47:55 +0800
Subject: [RFC Patch V1 21/30] mm, irqchip: Use cpu_to_mem()/numa_mem_id()
 to support memoryless node
In-Reply-To: <20140718124038.GE24496@titan.lakedaemon.net>
References: <1405064267-11678-1-git-send-email-jiang.liu@linux.intel.com>
 <1405064267-11678-22-git-send-email-jiang.liu@linux.intel.com>
 <20140718124038.GE24496@titan.lakedaemon.net>
Message-ID: <53CF306B.9080103@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,
	Thanks for your review. According to review comments,
we need to rework the patch set in another direction and will
give up this patch.
Regards!
Gerry

On 2014/7/18 20:40, Jason Cooper wrote:
> On Fri, Jul 11, 2014 at 03:37:38PM +0800, Jiang Liu wrote:
>> When CONFIG_HAVE_MEMORYLESS_NODES is enabled, cpu_to_node()/numa_node_id()
>> may return a node without memory, and later cause system failure/panic
>> when calling kmalloc_node() and friends with returned node id.
>> So use cpu_to_mem()/numa_mem_id() instead to get the nearest node with
>> memory for the/current cpu.
>>
>> If CONFIG_HAVE_MEMORYLESS_NODES is disabled, cpu_to_mem()/numa_mem_id()
>> is the same as cpu_to_node()/numa_node_id().
>>
>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>> ---
>>  drivers/irqchip/irq-clps711x.c |    2 +-
>>  drivers/irqchip/irq-gic.c      |    2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Do you have anything depending on this?  Can apply it to irqchip?  If
> you need to keep it with other changes,
> 
> Acked-by: Jason Cooper <jason@lakedaemon.net>
> 
> But please do let me know if I can take it.
> 
> thx,
> 
> Jason.
> 
