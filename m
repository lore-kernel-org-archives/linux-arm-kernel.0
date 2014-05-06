From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 6 May 2014 11:16:19 +0100
Subject: [PATCH V2] arm64: mm: Create gigabyte kernel logical mappings
 where possible
In-Reply-To: <20140506095850.GA23957@arm.com>
References: <1399043829-9036-1-git-send-email-steve.capper@linaro.org>
 <20140506095850.GA23957@arm.com>
Message-ID: <20140506101618.GA20232@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 06, 2014 at 10:58:53AM +0100, Catalin Marinas wrote:
> On Fri, May 02, 2014 at 04:17:09PM +0100, Steve Capper wrote:
> > We have the capability to map 1GB level 1 blocks when using a 4K
> > granule.
> > 
> > This patch adjusts the create_mapping logic s.t. when mapping physical
> > memory on boot, we attempt to use a 1GB block if both the VA and PA
> > start and end are 1GB aligned. This both reduces the levels of lookup
> > required to resolve a kernel logical address, as well as reduces TLB
> > pressure on cores that support 1GB TLB entries.
> > 
> > Signed-off-by: Steve Capper <steve.capper@linaro.org>
> 
> I think you need to patch kern_addr_valid as well for this (we recently
> pushed a patch to detect pmd block mappings).

Ahh, I see it, thanks. I will amend the logic.

Cheers,
-- 
Steve

> 
> -- 
> Catalin
