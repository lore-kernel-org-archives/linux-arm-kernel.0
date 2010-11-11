From: greg@kroah.com (Greg KH)
Date: Thu, 11 Nov 2010 05:17:56 -0800
Subject: [PATCH 00/02] staging: tidspbridge: 2.6.37-rcX fixes
In-Reply-To: <1289440225-27221-1-git-send-email-omar.ramirez@ti.com>
References: <1289440225-27221-1-git-send-email-omar.ramirez@ti.com>
Message-ID: <20101111131756.GA26064@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 10, 2010 at 07:50:23PM -0600, Omar Ramirez Luna wrote:
> Hi Greg,
> 
> Please consider the following patch set for tidspbridge driver in
> staging tree, the following has been tested on an omap3430 based board
> + gst-dsp environment. Many thanks to Felipe Contreras for piling this up,
> as I'm just propagating his patches.
> 
> First two patches:
> 1. omap: dsp: remove shm from normal memory
> 2. staging: tidspbridge: hardcode SCM macros while fix is upstreamed
> 
> Resolve a couple of build breaks due to adaptations for memblock
> and SCM layer.
> 
> (2) Is meant as a temporary fix, until the patches to fix this
>     (currently in review) are upstreamed. [1]
> 
> The rest of the series, is the revert of iommu migration changes. These
> are needed because, without modifications made to iommu module, they do not
> work; these modifications (on iommu code) didn't make it for the previous
> merge window either.
> 
> I will avoid posting the reverts (unless required), they can be found
> (along with the two patches of this series) at:
> 
> git://dev.omapzoom.org/pub/scm/tidspbridge/kernel-dspbridge.git 
> 	tidspbridge-2.6.37-rc1

I've pulled from this tree and pushed it out to the staging-linus branch
to get sent to Linus before .37 is released.

thanks,

greg k-h
