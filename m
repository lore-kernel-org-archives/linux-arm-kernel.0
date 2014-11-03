From: will.deacon@arm.com (Will Deacon)
Date: Mon, 3 Nov 2014 10:57:16 +0000
Subject: [PATCH v7 3/8] arm64: introduce is_device_dma_coherent
In-Reply-To: <alpine.DEB.2.02.1411031045340.22875@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1410261621200.22875@kaball.uk.xensource.com>
 <1414422568-19103-3-git-send-email-stefano.stabellini@eu.citrix.com>
 <alpine.DEB.2.02.1411031045340.22875@kaball.uk.xensource.com>
Message-ID: <20141103105716.GC23162@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 03, 2014 at 10:46:03AM +0000, Stefano Stabellini wrote:
> On Mon, 27 Oct 2014, Stefano Stabellini wrote:
> > Introduce a boolean flag and an accessor function to check whether a
> > device is dma_coherent. Set the flag from set_arch_dma_coherent_ops.
> > 
> > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > CC: will.deacon at arm.com
> 
> Will, Catalin,
> are you OK with this patch?

It would be nicer if the dma_coherent flag didn't have to be duplicated by
each architecture in dev_archdata. Is there any reason not to put it in the
core code?

Will
