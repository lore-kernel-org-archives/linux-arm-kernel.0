From: broonie@kernel.org (Mark Brown)
Date: Mon, 16 Dec 2013 11:33:26 +0000
Subject: [PATCH 4/6] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20131216105734.GA8931@e102568-lin.cambridge.arm.com>
References: <1386767606-6391-1-git-send-email-broonie@kernel.org>
 <1386767606-6391-4-git-send-email-broonie@kernel.org>
 <20131216105734.GA8931@e102568-lin.cambridge.arm.com>
Message-ID: <20131216113325.GD3185@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 10:57:34AM +0000, Lorenzo Pieralisi wrote:

> > +#define MPIDR_AFFINITY_LEVEL(mpidr, level) \
> > +       ((mpidr >> (MPIDR_LEVEL_BITS * level)) & MPIDR_LEVEL_MASK)

> This macros does not cover all affinity levels, I have a patch that
> implements this macro in my arm64 cpu_{suspend}/{resume} series.
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/213031.html

That hunk has been dropped from the latest postings of the series
anyway, please see the more current threads (and I'm going to do another
spin today too).  It'd be good to get things like your helpers
integrated so we don't have duplication of effort or people running
around trying to keep track of out of tree patches.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131216/2e74114f/attachment.sig>
