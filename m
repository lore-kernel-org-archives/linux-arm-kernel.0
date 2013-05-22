From: gang.chen@asianux.com (Chen Gang)
Date: Wed, 22 May 2013 17:29:51 +0800
Subject: [PATCH] kernel/sched/core.c: need return NULL when BUG() is
 defined as empty.
In-Reply-To: <20130522091156.GC18810@twins.programming.kicks-ass.net>
References: <5199D565.4070307@asianux.com>
 <20130522091156.GC18810@twins.programming.kicks-ass.net>
Message-ID: <519C900F.1040008@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2013 05:11 PM, Peter Zijlstra wrote:
> On Mon, May 20, 2013 at 03:48:53PM +0800, Chen Gang wrote:
>> > 
>> > When neither CONFIG_BUG nor HAVE_ARCH_BUG is defined, need let function
>> > return failure value ('NULL') instead of random value.
> What will such a kernel do? Happily continue running whenever we hit a
> BUG? that seems like a particularly bad idea. Should we not have a stub
> BUG() function like:
> 
> void BUG(void) __attribute__((noreturn))
> {
> 	local_irq_disable();
> 	while (1) ;
> }
> 
> Which would at least halt things?
> 
> 

At least for me, it is a good idea. :-)

In menuconfig we can set !CONFIG_BUG and !HAVE_ARCH_BUG manually under
any architectures:

  "> General setup > Configure standard kernel features (expert users) > BUG() Support"

So I think, we really need your patch.


Thanks.
-- 
Chen Gang

Asianux Corporation
