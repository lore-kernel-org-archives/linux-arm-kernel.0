From: cl@linux.com (Christopher Lameter)
Date: Wed, 21 Nov 2018 18:32:58 +0000
Subject: [PATCH v2 2/3] mm: Add support for SLAB_CACHE_DMA32
In-Reply-To: <20181111090341.120786-3-drinkcat@chromium.org>
References: <20181111090341.120786-1-drinkcat@chromium.org>
 <20181111090341.120786-3-drinkcat@chromium.org>
Message-ID: <01000167378bf31a-a639b46c-4d1d-43de-9bed-9cdd9c07fa94-000000@email.amazonses.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 11 Nov 2018, Nicolas Boichat wrote:

> SLAB_CACHE_DMA32 is only available after explicit kmem_cache_create calls,
> no default cache is created for kmalloc. Add a test in check_slab_flags
> for this.

This does not define the dma32 kmalloc array. Is that intentional? In that
case you need to fail any request for GFP_DMA32 coming in via kmalloc.
