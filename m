From: hch@lst.de (Christoph Hellwig)
Date: Tue, 17 Apr 2018 21:55:29 +0200
Subject: [PATCH 01/12] iommu-common: move to arch/sparc
In-Reply-To: <20180416.095833.969403163564136309.davem@davemloft.net>
References: <20180415145947.1248-1-hch@lst.de>
 <20180415145947.1248-2-hch@lst.de>
 <f0305a92-b206-1567-3c25-67fbd194047d@linux.vnet.ibm.com>
 <20180416.095833.969403163564136309.davem@davemloft.net>
Message-ID: <20180417195529.GA31335@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2018 at 09:58:33AM -0400, David Miller wrote:
> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Date: Mon, 16 Apr 2018 14:26:07 +0530
> 
> > On 04/15/2018 08:29 PM, Christoph Hellwig wrote:
> >> This code is only used by sparc, and all new iommu drivers should use the
> >> drivers/iommu/ framework.  Also remove the unused exports.
> >> 
> >> Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > Right, these functions are used only from SPARC architecture. Simple
> > git grep confirms it as well. Hence it makes sense to move them into
> > arch code instead.
> 
> Well, we put these into a common location and used type friendly for
> powerpc because we hoped powerpc would convert over to using this
> common piece of code as well.
> 
> But nobody did the powerpc work.
> 
> If you look at the powerpc iommu support, it's the same code basically
> for entry allocation.

I could also introduce a new config symbol and keep it in common code,
but it has been there for a while without any new user.

Right now it just means we built the code for everyone who selects
CONFIG_IOMMU_HELPER, which is just about anyone these days.
