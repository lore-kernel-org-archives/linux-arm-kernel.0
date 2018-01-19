From: robh@kernel.org (Rob Herring)
Date: Fri, 19 Jan 2018 15:28:36 -0600
Subject: [PATCH v4 5/8] ARM: l2x0: add marvell,ecc-enable property for
 aurora
In-Reply-To: <20180112012755.20495-6-chris.packham@alliedtelesis.co.nz>
References: <20180112012755.20495-1-chris.packham@alliedtelesis.co.nz>
 <20180112012755.20495-6-chris.packham@alliedtelesis.co.nz>
Message-ID: <20180119212836.r76seqe5dx6xim3w@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 02:27:52PM +1300, Chris Packham wrote:
> The aurora cache on the Marvell Armada-XP SoC supports ECC protection
> for the L2 data arrays. Add a "marvell,ecc-enable" device tree property
> which can be used to enable this.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> [jlu at pengutronix.de: use aurora specific define AURORA_ACR_ECC_EN]
> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/l2c2x0.txt | 2 ++
>  arch/arm/mm/cache-l2x0.c                         | 7 +++++++
>  2 files changed, 9 insertions(+)

The Calxeda PL310 has ECC too so maybe shouldn't have a vendor prefix, 
but I don't think anyone will ever care to change it at this point.

Reviewed-by: Rob Herring <robh@kernel.org>
