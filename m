From: cov@codeaurora.org (Christopher Covington)
Date: Fri, 11 Jul 2014 16:38:22 -0400
Subject: [PATCH 00/15] arm/arm64: fix use of irq_find_mapping outside
 of legal RCU context
In-Reply-To: <1404825038-547-1-git-send-email-marc.zyngier@arm.com>
References: <1404825038-547-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <53C04B3E.20908@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 07/08/2014 09:10 AM, Marc Zyngier wrote:
> A number of irqchip drivers are directly calling irq_find_mapping,
> which may use a rcu_read_lock call when walking the radix tree.

If this happens to be easy for you to determine: do direct callers of
irq_find_host such as irq_create_of_mapping have a similar problem with
irq_domain_mutex?

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
