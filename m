From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 17 Jan 2018 20:23:01 +0100
Subject: [PATCH] iommu/arm-smmu-v3: suppress MSI allocation failure message
In-Reply-To: <66706458-d971-be9b-4390-80a9be39248c@arm.com>
References: <1516214399-24012-1-git-send-email-nwatters@codeaurora.org>
 <2f651cfe-e006-cf1d-b624-08e2ba5340fc@arm.com>
 <66706458-d971-be9b-4390-80a9be39248c@arm.com>
Message-ID: <20180117192301.GV28161@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 07:08:39PM +0000, Marc Zyngier wrote:
> On 17/01/18 18:54, Robin Murphy wrote:

> Indeed. How about checking dev->msi_domain first, which should tell you
> whether it is even possible to allocate MSIs, and fallback to wired IRQs
> instead. That way, we keep the warning on genuine failures to allocate
> MSIs, and you get to add a nice "Falling back to wired interrupts"
> message when msi_domain is NULL.
> 
> Thoughts?

That sounds much better then the proposed patch. I am not really interested
in changing log-levels to make test-tools happy.


	Joerg
