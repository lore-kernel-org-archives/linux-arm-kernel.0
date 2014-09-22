From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 22 Sep 2014 18:10:25 +0100
Subject: [PATCH v6] arm64: fix VTTBR_BADDR_MASK
In-Reply-To: <542046CA.1060508@amd.com>
References: <20140908230852.2118.97400.stgit@joelaarch64.amd.com>
 <20140919152853.GH2295@e104818-lin.cambridge.arm.com>
 <20140919172846.GA12331@e104818-lin.cambridge.arm.com>
 <542046CA.1060508@amd.com>
Message-ID: <20140922171025.GN30085@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 22, 2014 at 04:56:58PM +0100, Joel Schopp wrote:
> > The TCR_EL2.PS setting should be done based on the ID_A64MMFR0_EL1
> > but you can do this in __do_hyp_init (it looks like this function
> > handles VTCR_EL2.PS already, not sure why it does do it for TCR_EL2 as
> > well).
> >
> > So IMO you only need about a few lines patch.
>
> My original patch to fix this problem was one line, so I'm perfectly
> happy with simplification.  But it would be nice if the other reviewers
> could agree with this approach.  With six versions that each addressed
> all the comments from reviewers I'd like it if the v7 that throws away
> most of that feedback didn't result in a v8 that puts it all back again.

I'm having some discussion with Christoffer around this. He will come up
with some patches on top of yours but I don't think the problem is that
simple. Basically the IPA size is restricted by the PARange but also
affected by the number of page table levels used by the host (both
having implications on VTCR_EL2.SL0).

-- 
Catalin
