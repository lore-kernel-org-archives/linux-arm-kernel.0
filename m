From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 08 Feb 2017 15:45:42 +0000
Subject: [PATCH 1/9] irqchip/gic-v3-its: Fix command buffer allocation
In-Reply-To: <278df776-4d6d-3b89-7a94-effaafcebeb0@codeaurora.org> (Shanker
 Donthineni's message of "Wed, 8 Feb 2017 09:31:00 -0600")
References: <20170201173833.12630-1-rrichter@cavium.com>
 <20170201173833.12630-2-rrichter@cavium.com>
 <87tw847njl.fsf@on-the-bus.cambridge.arm.com>
 <20170208144328.GS5020@rric.localdomain>
 <278df776-4d6d-3b89-7a94-effaafcebeb0@codeaurora.org>
Message-ID: <87h9447kk9.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08 2017 at  3:31:00 pm GMT, Shanker Donthineni <shankerd@codeaurora.org> wrote:
> Hi Marc,
>
> In teardown path, code is still calling 'kfree(its->cmd_base)' to free
> memory, this should be changed to
> 'free_pages(get_order(ITS_CMD_QUEUE_SZ).

Yup, I've noticed that too and amended the original patch.

Thanks,

	M.
-- 
Jazz is not dead, it just smell funny.
