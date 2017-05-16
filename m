From: oss@buserror.net (Scott Wood)
Date: Tue, 16 May 2017 00:41:28 -0500
Subject: [PATCH v3 00/11] soc/fsl/qbman: Enable QBMan on ARM Platforms
In-Reply-To: <1493674213-963-1-git-send-email-roy.pledge@nxp.com>
References: <1493674213-963-1-git-send-email-roy.pledge@nxp.com>
Message-ID: <1494913288.29095.7.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-05-01 at 17:30 -0400, Roy Pledge wrote:
> This patch series enables DPAA1 QBMan devices for ARM and
> ARM64 architectures. This allows the LS1043A and LS1046A to use
> QBMan functionality.
> 
> Changes since v2:
> Fixed some misspellings
> Added 'no-map' constraint to device tree bindings
> Described ordering contraint on regions in the device tree
> Removed confusing comment regarding non-shareable mappings
> Added warning if old reserved-memory technique is used on ARM
> 
> Changes since v1:
> Reworked private memory allocations to use shared-dma-pool on ARM platforms
> 
> Claudiu Manoil (2):
> ? soc/fsl/qbman: Drop L1_CACHE_BYTES compile time check
> ? soc/fsl/qbman: Add missing headers on ARM
> 
> Madalin Bucur (4):
> ? soc/fsl/qbman: Drop set/clear_bits usage
> ? soc/fsl/qbman: add QMAN_REV32
> ? soc/fsl/qbman: different register offsets on ARM
> ? fsl/soc/qbman: Enable FSL_LAYERSCAPE config on ARM
> 
> Roy Pledge (4):
> ? soc/fsl/qbman: Use shared-dma-pool for BMan private memory allocations
> ? soc/fsl/qbman: Use shared-dma-pool for QMan private memory allocations
> ? dt-bindings: soc/fsl: Update reserved memory binding for QBMan
> ? soc/fsl/qbman: Rework ioremap() calls for ARM/PPC
> 
> Valentin Rothberg (1):
> ? soc/fsl/qbman: Fix ARM32 typo

Acked-by: Scott Wood <oss@buserror.net>

-Scott
