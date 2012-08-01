From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Wed, 1 Aug 2012 13:53:06 -0700
Subject: [PATCH 11/11] ARM: Get rid of .LCcralign local label usage in
 alignment_trap macro
In-Reply-To: <20120730141544.GJ6802@n2100.arm.linux.org.uk>
References: <20120730115719.GA5742@lizard>
 <1343649500-18491-11-git-send-email-anton.vorontsov@linaro.org>
 <20120730141544.GJ6802@n2100.arm.linux.org.uk>
Message-ID: <20120801205306.GB20714@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 03:15:44PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 30, 2012 at 04:58:20AM -0700, Anton Vorontsov wrote:
> > This makes the code more izolated.
> > 
> > The downside of this is that we now have an additional branch and the
> > code itself is 8 bytes longer. But on the bright side, this new layout
> > can be more cache friendly since cr_alignment address might be already
> > in the cache line (not that I measured anything, it's just fun to think
> > about it).
> 
> The caches are harvard, so mixing data and code together does not increase
> performance.  Having data which is used by the same code in the same cache
> line results in better performance.
> 
> The additional branch will also cause a pipeline stall on older CPUs.
> 
> So no, I don't see any way that this is a performance improvement.  Please
> leave this as is.

Sure, will drop it.

Thanks!

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
