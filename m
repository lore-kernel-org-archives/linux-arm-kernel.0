From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Jul 2012 15:15:44 +0100
Subject: [PATCH 11/11] ARM: Get rid of .LCcralign local label usage in
 alignment_trap macro
In-Reply-To: <1343649500-18491-11-git-send-email-anton.vorontsov@linaro.org>
References: <20120730115719.GA5742@lizard>
 <1343649500-18491-11-git-send-email-anton.vorontsov@linaro.org>
Message-ID: <20120730141544.GJ6802@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 04:58:20AM -0700, Anton Vorontsov wrote:
> This makes the code more izolated.
> 
> The downside of this is that we now have an additional branch and the
> code itself is 8 bytes longer. But on the bright side, this new layout
> can be more cache friendly since cr_alignment address might be already
> in the cache line (not that I measured anything, it's just fun to think
> about it).

The caches are harvard, so mixing data and code together does not increase
performance.  Having data which is used by the same code in the same cache
line results in better performance.

The additional branch will also cause a pipeline stall on older CPUs.

So no, I don't see any way that this is a performance improvement.  Please
leave this as is.
