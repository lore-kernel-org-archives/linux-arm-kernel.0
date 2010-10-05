From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Tue, 5 Oct 2010 15:25:05 +0530
Subject: [PATCH v5 0/3] OMAP2/3: DMA: FIFO drain errata fixes
In-Reply-To: <1286261141-1039-1-git-send-email-peter.ujfalusi@nokia.com>
References: <1286261141-1039-1-git-send-email-peter.ujfalusi@nokia.com>
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB9FE819@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org 
> [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of Peter Ujfalusi
> Sent: Tuesday, October 05, 2010 12:16 PM
> To: Tony Lindgren
> Cc: linux-omap at vger.kernel.org; Jarkko Nikula; 
> linux-arm-kernel at lists.infradead.org; Russell King
> Subject: [PATCH v5 0/3] OMAP2/3: DMA: FIFO drain errata fixes
> 
> Hello,
> 
> This v5 series is based on the v3.
> The first two patch is the actual fix for the original 
> problems without any major change in the code (only handling 
> the corresponding erratas in the legacy way).
> The third patch in the series is optional, and it is 
> implementing (in one patch) the errata handling via flags. 
> This patch converts all errata cases to use the introduced 
> dma_errata variable via macros.
> 
> Tony: the first two patch need to go for 2.6.36, and if it is 
> possible it shall be backported to .33, .34, and .35 as well.
> The final patch in this series is optional, if you feel like 
> you can take it 
NAK
>(or drop it). 
ACK
>AFAIK the upcoming hwmod 
> changes to dma code will also have similar feature to handle 
> the erratas.
> I'm not sure what is the schedule for the hwmod conversion of dma...
v2 version of dma hwmod patches already exists in LOML which is 
already covering errata handling feature. I can rebase 1/3 and 2/3 
patches into dma hwmod errata handling.

v3 dma hwmod version will be posted soon once these fixes are rebased
and tested on all applicable omap's.

IOW, the errata handling feature comes along with all applicable erratas
ported with dma v3 hwmod series instead of having your patch 3/3 which is 
partially implemented.

-Manjunath
