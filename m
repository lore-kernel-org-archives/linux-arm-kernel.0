From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 2 Sep 2013 11:46:56 +0530
Subject: [PATCH 00/18] ARM: s3c64xx: Let amba-pl08x driver handle DMA
In-Reply-To: <1376243970-6489-1-git-send-email-tomasz.figa@gmail.com>
References: <1376243970-6489-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20130902061656.GF7376@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 11, 2013 at 07:59:12PM +0200, Tomasz Figa wrote:
> This is first non-RFC version of my patches extending support of
> amba-pl08x DMA engine driver to PL080S DMA engine (PL080 modified by
> Samsung) found in Samsung S3C64xx SoCs.
> 
> Due to changes scattered across different areas of kernel, patches are
> based on merged 3 branches:
>  - for-next of Kgene's Samsung tree,
>  - clk-next of Mike's clock tree,
>  - next of Vinod's slave DMA tree.
> 
> To ease testing I have prepared a branch in my private tree for anyone
> willing to check the patches out:
> 	git://github.com/tom3q/linux.git v3.12-pl080
> 
> Dependencies (already applied in my branch):
>  - for patches 14 and 16 - CCF-based clock driver for s3c64xx.
>  
> Some of the patches not related to the amba-pl08x driver itself
> can be likely applied into appropriate trees separately, namely:
>  - 09/18 - ASoC: Samsung: Do not queue cyclic buffers multiple times,
>  - 14/18 - clk: samsung: s3c64xx: Add aliases for DMA clocks.
>  
> After patch 14/18, both old and new DMA drivers can be supported on
> S3C64xx, depending on Kconfig options. Patches 15-18 remove the old driver
> leaving support only for the generic pl08x driver. Feel free to drop those
> patches for now if we want more testing, but I don't suspect any problems.
> 
> On S3C64xx-based Mini6410 and SMDK6410 boards, with I2S audio
> playback and capture (including full duplex operation) and also SPI
> using spidev:
Applied 1-8 to slave-dma tree, thanks

~Vinod
