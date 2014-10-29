From: broonie@kernel.org (Mark Brown)
Date: Wed, 29 Oct 2014 11:36:34 +0000
Subject: [PATCH] audio: sai: Add Power Management support
In-Reply-To: <1414552896-20797-1-git-send-email-b18965@freescale.com>
References: <1414552896-20797-1-git-send-email-b18965@freescale.com>
Message-ID: <20141029113634.GF18557@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141029/7349df14/attachment.sig>
