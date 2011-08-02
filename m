From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 3 Aug 2011 00:27:13 +0900
Subject: [PATCH 1/1] ASoC: core: cache index fix
In-Reply-To: <65EE16ACC360FA4D99C96DC085B3F7721F4616@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1312198690-13237-1-git-send-email-b29396@freescale.com>
	<20110801115150.GB16629@opensource.wolfsonmicro.com>
	<65EE16ACC360FA4D99C96DC085B3F7721F410B@039-SN1MPN1-002.039d.mgd.msft.net>
	<20110802083850.GB9553@opensource.wolfsonmicro.com>
	<65EE16ACC360FA4D99C96DC085B3F7721F427D@039-SN1MPN1-002.039d.mgd.msft.net>
	<65EE16ACC360FA4D99C96DC085B3F7721F4616@039-SN1MPN1-002.039d.mgd.msft.net>
Message-ID: <20110802152712.GC25884@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 02, 2011 at 01:17:12PM +0000, Dong Aisheng-B29396 wrote:

> For rbtree, i tried that only changed snd_soc_rbtree_cache_init as follows
> Could work. Then rbtree_cache_read/write do not need to care about step.
> This could reduce many code changes and complexity.
> But the disadvantage is that the rbtree cache may not be able to find a
> adjacent register in the same block if the reg step is 2.
> However it works.
> Do you think this is acceptable?

No, like I've been saying the rbtree should have *no* visibility of step
sizes.  This is exactly the sort of complexity and fragility that I've
been raising as an issue.
