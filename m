From: will.deacon@arm.com (Will Deacon)
Date: Tue, 19 Aug 2014 14:00:05 +0100
Subject: [PATCH 2/6] iommu/arm-smmu: add support for specifying regulators
In-Reply-To: <1407891099-24641-3-git-send-email-mitchelh@codeaurora.org>
References: <1407891099-24641-1-git-send-email-mitchelh@codeaurora.org>
 <1407891099-24641-3-git-send-email-mitchelh@codeaurora.org>
Message-ID: <20140819130005.GP23128@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 01:51:35AM +0100, Mitchel Humpherys wrote:
> On some power-constrained platforms it's useful to disable power when a
> device is not in use. Add support for specifying regulators for SMMUs
> and only leave power on as long as the SMMU is in use (attached).

... and for bypass mode? My comments for clks largely apply here too -- I'd
much rather see this in domain_init/domain_destroy with appropriate
refcounting. It's just too much of a mess having these calls littered around
the driver.

Will
