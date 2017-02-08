From: robert.richter@cavium.com (Robert Richter)
Date: Wed, 8 Feb 2017 16:36:58 +0100
Subject: [PATCH 1/9] irqchip/gic-v3-its: Fix command buffer allocation
In-Reply-To: <278df776-4d6d-3b89-7a94-effaafcebeb0@codeaurora.org>
References: <20170201173833.12630-1-rrichter@cavium.com>
 <20170201173833.12630-2-rrichter@cavium.com>
 <87tw847njl.fsf@on-the-bus.cambridge.arm.com>
 <20170208144328.GS5020@rric.localdomain>
 <278df776-4d6d-3b89-7a94-effaafcebeb0@codeaurora.org>
Message-ID: <20170208153658.GT5020@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.02.17 09:31:00, Shanker Donthineni wrote:
> In teardown path, code is still calling 'kfree(its->cmd_base)' to free
> memory, this should be changed to 'free_pages(get_order(ITS_CMD_QUEUE_SZ).

Hmm, right. This is later removed in the series, but should be part of
this patch. Should I respin this one?

-Robert
