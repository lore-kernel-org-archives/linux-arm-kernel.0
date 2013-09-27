From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Sep 2013 14:05:28 +0100
Subject: [PATCH 6/9] iommu/arm-smmu: Support buggy implemenations where
 all config accesses are secure
In-Reply-To: <1380234982-1677-7-git-send-email-andreas.herrmann@calxeda.com>
References: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
 <1380234982-1677-7-git-send-email-andreas.herrmann@calxeda.com>
Message-ID: <20130927130527.GH9520@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 11:36:18PM +0100, Andreas Herrmann wrote:
> In such a case we have to use secure aliases of some non-secure
> registers.
> 
> This behaviour is controlled via a flag in smmu->bugs. It is set
> based on DT information when probing an SMMU device.

:(

I guess my main comment is just some understanding on how things are wired.
It's *just* the configuration access that is secure, right? Device
transactions are non-secure, so the existing TLB invalidation code will work
correctly?

Will
