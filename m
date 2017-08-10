From: robh@kernel.org (Rob Herring)
Date: Wed, 9 Aug 2017 19:10:21 -0500
Subject: [PATCH 2/7] mtd: spi-nor: cadence-quadspi: Add support to enable
 loopback clock circuit
In-Reply-To: <20170801045434.8733-3-vigneshr@ti.com>
References: <20170801045434.8733-1-vigneshr@ti.com>
 <20170801045434.8733-3-vigneshr@ti.com>
Message-ID: <20170810001021.ayygkgy6xwnrxghl@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 01, 2017 at 10:24:29AM +0530, Vignesh R wrote:
> Cadence QSPI IP has a adapted loopback circuit which can be enabled by
> setting BYPASS field to 0 in READCAPTURE register. It enables use of
> QSPI return clock to latch the data rather than the internal QSPI
> reference clock. For high speed operations, adapted loopback circuit
> using QSPI return clock helps to increase data valid window.
> 
> Add DT parameter cdns,rclk-en to help enable adapted loopback circuit
> for boards which do have QSPI return clock provided.
> This patch also modifies cqspi_readdata_capture() function's bypass
> parameter to bool to match how its used in the function.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  Documentation/devicetree/bindings/mtd/cadence-quadspi.txt | 3 +++
>  drivers/mtd/spi-nor/cadence-quadspi.c                     | 8 ++++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)

Please separate bindings to a separate patch or patches.

Rob
