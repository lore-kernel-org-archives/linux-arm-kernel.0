From: lethal@linux-sh.org (Paul Mundt)
Date: Fri, 2 Jul 2010 16:00:01 +0900
Subject: [RFC 1/3] mm: iommu: An API to unify IOMMU,
	CPU and device memory management
In-Reply-To: <4C2C40C2.50106@codeaurora.org>
References: <1277877350-2147-1-git-send-email-zpfeffer@codeaurora.org>
	<20100630164058.aa6aa3a2.randy.dunlap@oracle.com>
	<4C2C40C2.50106@codeaurora.org>
Message-ID: <20100702070001.GA25679@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 01, 2010 at 12:16:18AM -0700, Zach Pfeffer wrote:
> Thank you for the corrections. I'm correcting them now. Some responses:
> 
> Randy Dunlap wrote:
> >> +    struct vcm *vcm_create(size_t start_addr, size_t len);
> > 
> > Seems odd to use size_t for start_addr.
> 
> I used size_t because I wanted to allow the start_addr the same range
> as len. Is there a better type to use? I see 'unsigned long' used
> throughout the mm code. Perhaps that's better for both the start_addr
> and len.
> 
phys_addr_t or resource_size_t.
