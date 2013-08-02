From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 2 Aug 2013 12:59:00 +0100
Subject: [PATCH RFC 1/8] arm: make SWIOTLB available
In-Reply-To: <334c4fe7-e40c-489c-84db-9bb58c705d44@email.android.com>
References: <alpine.DEB.2.02.1307311833040.4893@kaball.uk.xensource.com>
 <1375292732-7627-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <334c4fe7-e40c-489c-84db-9bb58c705d44@email.android.com>
Message-ID: <alpine.DEB.2.02.1308021250050.4893@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 31 Jul 2013, Konrad Rzeszutek Wilk wrote:
> Stefano Stabellini <stefano.stabellini@eu.citrix.com> wrote:
> >Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> >CC: will.deacon at arm.com
> >CC: linux at arm.linux.org.uk
> >---
> > arch/arm/Kconfig                   |    7 +++++++
> > arch/arm/include/asm/dma-mapping.h |   24 ++++++++++++++++++++++++
> > 2 files changed, 31 insertions(+), 0 deletions(-)
> >
> >diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >index ba412e0..05125ab 100644
> >--- a/arch/arm/Kconfig
> >+++ b/arch/arm/Kconfig
> >@@ -1832,6 +1832,13 @@ config CC_STACKPROTECTOR
> > 	  neutralized via a kernel panic.
> > 	  This feature requires gcc version 4.2 or above.
> > 
> >+config SWIOTLB
> >+	def_bool y
> >+	select NEED_SG_DMA_LENGTH
> >+
> >+config IOMMU_HELPER
> >+	def_bool SWIOTLB
> >+
> 
> Could you explain the purpose of these two a bit more please? 

SWIOTLB is not available on arm at the moment.
We need to make it available, otherwise SWIOTLB_XEN won't be able to
select it.

Similarly, IOMMU_HELPER is another lib Kconfig symbol needed by SWIOTLB
to compile.
