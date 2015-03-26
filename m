From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 26 Mar 2015 21:53:08 +0000
Subject: [PATCH v3 09/11] KVM: arm/arm64: merge GICv3 RD_base and
 SGI_base register frames
In-Reply-To: <1427380778-942-10-git-send-email-andre.przywara@arm.com>
References: <1427380778-942-1-git-send-email-andre.przywara@arm.com>
 <1427380778-942-10-git-send-email-andre.przywara@arm.com>
Message-ID: <20150326215308.74b994ff@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Mar 2015 14:39:36 +0000
Andre Przywara <andre.przywara@arm.com> wrote:

> Currently we handle the redistributor registers in two separate MMIO
> regions, one for the overall behaviour and SPIs and one for the
> SGIs/PPIs. That latter forces the creation of _two_ KVM I/O bus
> devices for each redistributor.
> Since the spec mandates those two pages to be contigious, we could as
> well merge them and save the churn with the second KVM I/O bus device.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

I wonder why we didn't have it that way the first place...

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
