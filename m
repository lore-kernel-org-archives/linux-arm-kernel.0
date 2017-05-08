From: robert.richter@cavium.com (Robert Richter)
Date: Mon, 8 May 2017 12:04:43 +0200
Subject: [PATCH v3 1/7] iommu/arm-smmu-v3: Introduce SMMU option
 PAGE0_REGS_ONLY for ThunderX2 errata #74
In-Reply-To: <b4881237-aca6-63ca-467e-30e36b1f02df@arm.com>
References: <1493986091-30521-1-git-send-email-gakula@caviumnetworks.com>
 <1493986091-30521-2-git-send-email-gakula@caviumnetworks.com>
 <20170505230328.GN4906@rric.localdomain>
 <20170508091739.GA26003@virtx40>
 <b4881237-aca6-63ca-467e-30e36b1f02df@arm.com>
Message-ID: <20170508100443.GG16981@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.05.17 10:59:46, Robin Murphy wrote:
> On 08/05/17 10:17, Linu Cherian wrote:
> > This actually results in more lines of changes. If you think the below
> > approach is still better, will post a V4 of this series with this change.
> 
> Why not just do this?:
> 
> static inline unsigned long page1_offset_adjust(
> 	unsigned long off, struct arm_smmu_device *smmu)
> {
> 	if (off > SZ_64K && ARM_SMMU_PAGE0_REGS_ONLY(smmu))
> 		return (off - SZ_64K);
> 
> 	return off;
> }
> 
> AFAICS that should be the least disruptive way to go about it.

Yeah, let's go with this.

Thanks Robin,

-Robert
