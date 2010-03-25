From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Mar 2010 15:10:31 +0000
Subject: [PATCH] ARM: Fix virtual kernel memory printing for sparsemem
In-Reply-To: <20100325145324.12837.85927.stgit@e102109-lin.cambridge.arm.com>
References: <20100325145324.12837.85927.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100325151030.GD6590@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 02:53:24PM +0000, Catalin Marinas wrote:
> Commit db9ef1a introduced information printing for the virtual kernel
> memory map but page/end calculation using the pfn goes wrong and
> page_count() generates a data abort or alignment fault (possibly because
> it gets to an uninitialised page structure that looks like a compound
> page).

While this looks fine, I'd like to see a lot of Tested-by's against
this before it's merged - we've had similar code in show_mem()
which has proven to be quite problematical to get right for all the
various different combinations we have.

However, we also have the same method in show_mem() which we know
works fine, so I'd also like to see the problem with using it in
mem_init() fully analysed - rather than a "possibly because".
