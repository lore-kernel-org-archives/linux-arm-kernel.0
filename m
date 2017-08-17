From: robh@kernel.org (Rob Herring)
Date: Thu, 17 Aug 2017 17:00:56 -0500
Subject: [PATCH v2 3/5] mtd: spi-nor: cadence-quadspi: Add new binding to
 enable loop-back circuit
In-Reply-To: <20170816045053.15492-4-vigneshr@ti.com>
References: <20170816045053.15492-1-vigneshr@ti.com>
 <20170816045053.15492-4-vigneshr@ti.com>
Message-ID: <20170817220056.q572ix5kzjawf2gf@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 16, 2017 at 10:20:51AM +0530, Vignesh R wrote:
> Cadence QSPI IP has a adapted loop-back circuit which can be enabled by
> setting BYPASS field to 0 in READCAPTURE register. It enables use of
> QSPI return clock to latch the data rather than the internal QSPI
> reference clock. For high speed operations, adapted loop-back circuit
> using QSPI return clock helps to increase data valid window.
> 
> Add DT parameter cdns,rclk-en to help enable adapted loop-back circuit
> for boards which do have QSPI return clock provided. Update binding
> documentation for the same.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  Documentation/devicetree/bindings/mtd/cadence-quadspi.txt | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
