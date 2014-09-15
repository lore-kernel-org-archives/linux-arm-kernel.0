From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 15 Sep 2014 04:38:29 +0200
Subject: [RFC][PATCH] devicetree: Add master-id-bits property to the iommu
 device
In-Reply-To: <1410718646-9710-1-git-send-email-Varun.Sethi@freescale.com>
References: <1410718646-9710-1-git-send-email-Varun.Sethi@freescale.com>
Message-ID: <201409150438.29649.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 14 September 2014, Varun Sethi wrote:
> "master-id-bits" property added to the IOMMU device node. This property can
> be used by the IOMMU driver to match relevan bits in the master id expressed
> by a DMA master.
> 
> This can be used to mask out certain bits that get added to the device master id
> due to IOMMU topology. For example, in case of MMU-500 the TBUID gets appended to
> the master id. This prevents sharing of a stream ID, amongst devices which are
> connected to different TBUs. 
> 
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>

This seems rather specific to MMU-500. I don't think that most IOMMUs would
use the term 'master ID', 'stream ID' or even the general concept, and you don't
expand the acronym 'TBU'. I've seen many IOMMUs and I don't even know what
that means.

Why do you think this is something that is needed to be known at the global
level, rather than a property for some individual drivers?

	Arnd
