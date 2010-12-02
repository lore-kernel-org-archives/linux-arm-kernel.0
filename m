From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Dec 2010 22:19:09 +0000
Subject: [PATCH] arm: dma-mapping: move consistent_init to early_initcall
In-Reply-To: <1291327879-28073-1-git-send-email-johlstei@codeaurora.org>
References: <1291327879-28073-1-git-send-email-johlstei@codeaurora.org>
Message-ID: <20101202221909.GK29347@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 02, 2010 at 02:11:18PM -0800, Jeff Ohlstein wrote:
> Some machines require the use of coherent memory to bring up auxillary
> cpus, and thus want to use dma_alloc_coherent prior to smp_init
> completing.

I'd like to see the rest of the code to indicate why you need DMA
coherent memory for SMP boot.  It seems to me quite unnecessary.
DMA coherent memory is meant for talking to devices, not to other
CPUs which will be part of the symmetric part of the system.
