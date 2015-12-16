From: panand@redhat.com (Pratyush Anand)
Date: Wed, 16 Dec 2015 16:02:59 +0530
Subject: [PATCH v12 08/16] arm64/kexec: Add core kexec support
In-Reply-To: <56712F3A.7040805@arm.com>
References: <cover.1448403503.git.geoff@infradead.org>
 <6ac232ad37d6b02cf2d5848b15236f26f5ac61ac.1448403503.git.geoff@infradead.org>
 <20151215182932.GF353@arm.com>
 <1450224870.24127.130.camel@infradead.org>
 <20151216071804.GI4674@dhcppc13.redhat.com>
 <56712F3A.7040805@arm.com>
Message-ID: <20151216103259.GA316@dhcppc13.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/12/2015:09:30:34 AM, James Morse wrote:
> On 16/12/15 07:18, Pratyush Anand wrote:
> > We execute arm64_relocate_new_kernel() code with I-cache disabled. So, do we
> > really need to invalidate I-cache?
> 
> I got bitten by this, see Mark's earlier reply[0]:
> 
> Mark Rutland wrote:
> > The SCTLR_ELx.I only affects the attributes that the I-cache uses to
> > fetch with, not whether it is enabled (it cannot be disabled
> > architecturally).

Thanks James for pointing to it. I had missed that.

~Pratyush
