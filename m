From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 26 Jan 2017 18:18:58 +0100
Subject: [PATCH 0/5] Implement SMMU passthrough using the default domain
In-Reply-To: <010801d27654$47b7e450$d727acf0$@codeaurora.org>
References: <1484849955-1871-1-git-send-email-will.deacon@arm.com>
 <010801d27654$47b7e450$d727acf0$@codeaurora.org>
Message-ID: <20170126171857.GE27598@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 08:42:23PM +0530, Sricharan wrote:
> Thanks for this series. We had a case with the GPU.
> The GPU's iommu was setup by kernel and the GPU
> also does dynamic updates for on-the-fly switching between
> process pagetables.  GPU driver was not using DMA domain and
> the GPU's firmware was always expecting to run out  of contextbank
>  '0' (although not correct) , which was not the case after the DMA domain
> was made default  as '0' was getting allocated for DMA domain and
> there were concerns about reusing the DMA domain as well.
> Now with this series, looks there is an way out of that that can be tried.
> 
> So should the default domain not be per device specific selectable ?

Note that iommu-drivers can request direct-mapping for any given device
on its initializtion. This is used on x86 for devices that need a 1-1
mapping for some reason.

Also device drivers can use the iommu-api and assign their own domain to
a device, which allows them to manage the dma address space on their
own.


	Joerg
