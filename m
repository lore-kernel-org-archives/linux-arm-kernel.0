From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 15 Oct 2012 12:06:22 -0600
Subject: [PATCH] ARM: tegra: remove <mach/dma.h>
In-Reply-To: <1349206245-22560-1-git-send-email-swarren@wwwdotorg.org>
References: <1349206245-22560-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <507C509E.2020103@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/2012 01:30 PM, Stephen Warren wrote:
> Remove includes of <mach/dma.h> from sound/soc; nothing from it is used.
> 
> Remove include of <mach/dma.h> from mach-tegra/apbio.c; since the DMA
> transfers made by this file don't need flow-control with any peripheral,
> there's no need to set any slave ID.
> 
> Once those changes are made, there are no remaining users of <mach/dma.h>
> so remove it. Drivers should get this information from device tree. This
> removal is necessary for single zImage.

Applied to Tegra's for-3.8/cleanup branch.
