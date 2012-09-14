From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 14 Sep 2012 15:05:57 +0100
Subject: [PATCH v4 02/24] xen/arm: hypercalls
In-Reply-To: <alpine.DEB.2.02.1209141458340.29232@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1209141145150.29232@kaball.uk.xensource.com>
 <1347621207-11294-2-git-send-email-stefano.stabellini@eu.citrix.com>
 <50533500.2020606@arm.com>
 <alpine.DEB.2.02.1209141458340.29232@kaball.uk.xensource.com>
Message-ID: <505339C5.60907@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/09/12 15:02, Stefano Stabellini wrote:
> On Fri, 14 Sep 2012, Marc Zyngier wrote:
>>> +/* HVC 0xEA1 */
>>> +#ifdef CONFIG_THUMB2_KERNEL
>>> +#define xen_hvc .word 0xf7e08ea1
>>> +#else
>>> +#define xen_hvc .word 0xe140ea71
>>> +#endif
>>
>> You should consider using Dave Martin's opcode injection series for
>> that. The patches are already in Russell's for-next branch.
> 
> I am all for using Dave's patches and I have even already sent a patch
> to change the wrappers to use __HVC:
> 
> http://marc.info/?l=linux-kernel&m=134513261623427&w=2
> 
> I have only temporarely dropped it, only to reduce the amount of
> external dependencies of this series. It already depends on Konrad's
> stable/for-linus-3.7, so I would rather send this patch out later on its
> own...

Fair enough. As long as there's a plan to fix this soon enough, it
should be alright.

	M.
-- 
Jazz is not dead. It just smells funny...
