From: alison.wang@freescale.com (Huan Wang)
Date: Thu, 30 Oct 2014 14:55:47 +0000
Subject: [PATCH] audio: sai: Add Power Management support
In-Reply-To: <20141029113634.GF18557@sirena.org.uk>
References: <1414552896-20797-1-git-send-email-b18965@freescale.com>,
 <20141029113634.GF18557@sirena.org.uk>
Message-ID: <1414680936299.29360@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Oct 29, 2014 at 11:21:36AM +0800, Alison Wang wrote:
> This patch adds Power Management support for SAI.
> Activate regmap cache with REGCACHE_RBTREE, and use

Are you sure that REGCACHE_RBTREE is the best option here?  For MMIO
devices the cost tradeoff for the rbtree is usually higher than people
like so flat caches are preferred.  But if it works for you that's fine,
this shouldn't be *that* performance critical.

I'm also a bit surprised that this works without register defaults being
provided since we need to make sure we allocate the rbtree nodes outside
of the spinlock we use to lock MMIO access - was this tested with
mainline?

[Alison Wang] I tested rbtree and flat caches, they both work. But I didn't pay attention to the cost tradeoff and register defaults before, so I think flat caches are preferred now. 

Thanks.

Best Regards,
Alison Wang
