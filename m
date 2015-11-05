From: cl@linux.com (Christoph Lameter)
Date: Thu, 5 Nov 2015 11:39:46 -0600 (CST)
Subject: [PATCH] mm: slab: Only move management objects off-slab for
 sizes larger than KMALLOC_MIN_SIZE
In-Reply-To: <1446724235-31400-1-git-send-email-catalin.marinas@arm.com>
References: <20151105043155.GA20374@js1304-P5Q-DELUXE>
 <1446724235-31400-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <alpine.DEB.2.20.1511051139220.28479@east.gentwo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 5 Nov 2015, Catalin Marinas wrote:

> This patch introduces an OFF_SLAB_MIN_SIZE macro which takes
> KMALLOC_MIN_SIZE into account. It also solves a slab bug on arm64 where
> the first kmalloc_cache to be initialised after slab_early_init = 0,
> "kmalloc-128", fails to allocate off-slab management objects from the
> same "kmalloc-128" cache.

Acked-by: Christoph Lameter <cl@linux.com>
