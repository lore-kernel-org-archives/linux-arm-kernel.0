From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 29 Jul 2014 15:28:25 +0100
Subject: [PATCH 00/15] arm/arm64: fix use of irq_find_mapping outside of
 legal RCU context
In-Reply-To: <53C04B3E.20908@codeaurora.org> (Christopher Covington's message
 of "Fri, 11 Jul 2014 21:38:22 +0100")
References: <1404825038-547-1-git-send-email-marc.zyngier@arm.com>
 <53C04B3E.20908@codeaurora.org>
Message-ID: <87mwbskzna.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11 2014 at  9:38:22 pm BST, Christopher Covington <cov@codeaurora.org> wrote:
> Hi Mark,
>
> On 07/08/2014 09:10 AM, Marc Zyngier wrote:
>> A number of irqchip drivers are directly calling irq_find_mapping,
>> which may use a rcu_read_lock call when walking the radix tree.
>
> If this happens to be easy for you to determine: do direct callers of
> irq_find_host such as irq_create_of_mapping have a similar problem with
> irq_domain_mutex?

Definitely not from this problem. irq_find_host doesn't use RCU at all,
so it shouldn't be an issue.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
