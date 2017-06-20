From: robert.richter@cavium.com (Robert Richter)
Date: Tue, 20 Jun 2017 10:51:23 +0200
Subject: [PATCH v7 1/3] ACPI/IORT: Fixup SMMUv3 resource size for Cavium
 ThunderX2 SMMUv3 model
In-Reply-To: <20170620081943.GT658@rric.localdomain>
References: <1496145821-3411-1-git-send-email-gakula@caviumnetworks.com>
 <1496145821-3411-2-git-send-email-gakula@caviumnetworks.com>
 <20170620081943.GT658@rric.localdomain>
Message-ID: <20170620085123.GF16981@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.06.17 10:19:43, Robert Richter wrote:
> On 30.05.17 17:33:39, Geetha sowjanya wrote:
> > From: Linu Cherian <linu.cherian@cavium.com>

> > +	/*
> > +	 * Override the size, for Cavium ThunderX2 implementation
> > +	 * which doesn't support the page 1 SMMU register space.
> > +	 */
> > +	if (smmu->model == ACPI_IORT_SMMU_CAVIUM_CN99XX)
> 
> Geetha,
> 
> please resubmit the series since the macro changed to
> ACPI_IORT_SMMU_V3_CAVIUM_CN99XX:
> 
>  https://github.com/acpica/acpica/commit/d00a4eb86e64bb4fa70f57ab5e5ca0a4ca2ad8ef#diff-a572aac2ccc26fe4a901616d7fdba859R1053

Rafael, Bob,

btw, I haven't seen

 https://github.com/acpica/acpica/commit/d00a4eb86e64

yet in linux-pm:linux-next. We would like to see this in 4.13 also. Is
it on the way already?

Thanks,

-Robert
