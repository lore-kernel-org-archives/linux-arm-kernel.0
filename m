From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 26 Aug 2014 16:10:00 -0700
Subject: [PATCH 0/2] ARM: Remove lowmem limit for default CMA region
In-Reply-To: <1408610714-16204-1-git-send-email-m.szyprowski@samsung.com>
References: <1408610714-16204-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20140826161000.c760fadf0d7223372524d2ce@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Aug 2014 10:45:12 +0200 Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> Russell King recently noticed that limiting default CMA region only to
> low memory on ARM architecture causes serious memory management issues
> with machines having a lot of memory (which is mainly available as high
> memory). More information can be found the following thread:
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/348441/
> 
> Those two patches removes this limit letting kernel to put default CMA
> region into high memory when this is possible (there is enough high
> memory available and architecture specific DMA limit fits).
> 
> This should solve strange OOM issues on systems with lots of RAM
> (i.e. >1GiB) and large (>256M) CMA area.

What do we think is the priority on these fixes?  3.17 or 3.18?
