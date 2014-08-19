From: joel.schopp@amd.com (Joel Schopp)
Date: Tue, 19 Aug 2014 10:16:12 -0500
Subject: [PATCH v5] arm64: fix VTTBR_BADDR_MASK
In-Reply-To: <20140819145933.GF31086@cbox>
References: <20140818203604.4654.99905.stgit@joelaarch64.amd.com>
 <20140819122420.GC31086@cbox> <53F35DFD.9070804@amd.com>
 <20140819143834.GE31086@cbox> <53F363E3.8060108@amd.com>
 <20140819145933.GF31086@cbox>
Message-ID: <53F36A3C.4060104@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> hmmm, the point is that we need to ensure that we have a properly
> aligned allocated PGD, that's what this patch currently addresses, and as
> you pointed out, the BUG_ON() just before trying to run a VM is not the
> nicest solution - we should really be dealing with this properly at
> allocation time.
>
> But, if you don't have time to look at that, then ok, I'll have to pick
> it up myself.
>
> However, you are hinting that we do not support 4 levels of page tables,
> yet you do allow the t0sz_to_vttbr_x funciton to pass even when using
> t0sz values only supported under 4 levels of page tables....  What is
> the rationale for that?
Minimizing merge conflicts. I figure both are going in within the next
month or two.
