From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 27 Mar 2015 17:01:10 +0100
Subject: [PATCH v3 09/11] KVM: arm/arm64: merge GICv3 RD_base and
 SGI_base register frames
In-Reply-To: <1427380778-942-10-git-send-email-andre.przywara@arm.com>
References: <1427380778-942-1-git-send-email-andre.przywara@arm.com>
 <1427380778-942-10-git-send-email-andre.przywara@arm.com>
Message-ID: <20150327160110.GE5121@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 02:39:36PM +0000, Andre Przywara wrote:
> Currently we handle the redistributor registers in two separate MMIO
> regions, one for the overall behaviour and SPIs and one for the
> SGIs/PPIs. That latter forces the creation of _two_ KVM I/O bus
> devices for each redistributor.
> Since the spec mandates those two pages to be contigious, we could as
> well merge them and save the churn with the second KVM I/O bus device.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
