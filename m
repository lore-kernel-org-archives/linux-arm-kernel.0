From: dwalker@fifo99.com (Daniel Walker)
Date: Wed, 14 Mar 2012 08:05:53 -0700
Subject: [PATCH v3 2/2] DMAEngine: Add DMAEngine driver based on old MSM
 DMA APIs
In-Reply-To: <4F5F41AF.1090907@codeaurora.org>
References: <1331548364-27845-1-git-send-email-kumarrav@codeaurora.org>
 <20120312201421.GA3459@fifo99.com>
 <4F5F41AF.1090907@codeaurora.org>
Message-ID: <20120314150533.GA8757@fifo99.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2012 at 06:16:39PM +0530, Ravi Kumar V wrote:
> On 3/13/2012 1:44 AM, Daniel Walker wrote:
> >On Mon, Mar 12, 2012 at 04:02:44PM +0530, Ravi Kumar V wrote:
> >>Add DMAEngine based driver using the old MSM DMA APIs internally.
> >
> >What do you mean by this?
> >
> There is a MSM DMA driver in arch/arm/mach-msm/ which is not in
> dmaengine framework standards, but that driver is been used by
> client drivers nand, eMMC and serial drivers. Now if we implement
> the whole dma driver using dmaengine framework then nand, eMMC like
> drivers will be failed as they are using old dma driver API's, so
> instead of implementing new driver from scratch we are keeping the
> old dma API's as it is and using those API's in new dmaengine
> framework.So that we can convert clients drivers to use dma engine
> framework.

Did you investigate converting the drivers (nand, eMMC, serial) ? It
seems like there would be a 1:1 mapping between the API's , so it might
only be a find->replace operation.

Daniel
