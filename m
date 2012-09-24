From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 24 Sep 2012 11:56:21 -0400 (EDT)
Subject: [PATCH v3 RESEND 05/17] ARM: LPAE: support 64-bit virt_to_phys
 patching
In-Reply-To: <20120924151305.GA14198@arm.com>
References: <1348242975-19184-1-git-send-email-cyril@ti.com>
 <1348242975-19184-6-git-send-email-cyril@ti.com>
 <20120924151305.GA14198@arm.com>
Message-ID: <alpine.LFD.2.02.1209241152540.6667@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 24 Sep 2012, Catalin Marinas wrote:

> On Fri, Sep 21, 2012 at 04:56:03PM +0100, Cyril Chemparathy wrote:
> > This patch adds support for 64-bit physical addresses in virt_to_phys()
> > patching.  This does not do real 64-bit add/sub, but instead patches in the
> > upper 32-bits of the phys_offset directly into the output of virt_to_phys.
> 
> So this assumes that for the kernel linear mapping, all the physical
> addresses have the same upper 32-bit. That's a good optimisation but I
> haven't seen this check when calculating lowmem in sanity_check_meminfo.
> Someone may build platform with memory starting at 3GB and going across
> the 4GB limit.

Good point.  We better get an early warning if that happens.


Nicolas
