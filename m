From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 08 Feb 2017 16:00:19 +0000
Subject: [PATCH 1/9] irqchip/gic-v3-its: Fix command buffer allocation
In-Reply-To: <20170208153658.GT5020@rric.localdomain> (Robert Richter's
 message of "Wed, 8 Feb 2017 16:36:58 +0100")
References: <20170201173833.12630-1-rrichter@cavium.com>
 <20170201173833.12630-2-rrichter@cavium.com>
 <87tw847njl.fsf@on-the-bus.cambridge.arm.com>
 <20170208144328.GS5020@rric.localdomain>
 <278df776-4d6d-3b89-7a94-effaafcebeb0@codeaurora.org>
 <20170208153658.GT5020@rric.localdomain>
Message-ID: <8760kk7jvw.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08 2017 at  3:36:58 pm GMT, Robert Richter <robert.richter@cavium.com> wrote:
> On 08.02.17 09:31:00, Shanker Donthineni wrote:
>> In teardown path, code is still calling 'kfree(its->cmd_base)' to free
>> memory, this should be changed to 'free_pages(get_order(ITS_CMD_QUEUE_SZ).
>
> Hmm, right. This is later removed in the series, but should be part of
> this patch. Should I respin this one?

Nope, I've hacked it.

Thanks,

	M.
-- 
Jazz is not dead, it just smell funny.
