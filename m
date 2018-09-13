From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 13 Sep 2018 00:51:19 -0300
Subject: [PATCH] soc: imx: gpc: set DMA mask for PD platform devices
In-Reply-To: <20180912152702.14640-1-l.stach@pengutronix.de>
References: <20180912152702.14640-1-l.stach@pengutronix.de>
Message-ID: <CAOMZO5A2FmvAf3Fb4bk6bCu6XgwLEC_COvtsTWtcLvU=tCK+0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,

On Wed, Sep 12, 2018 at 12:27 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> The PD platform devices aren't DMA capable (as is correctly reflected
> in with a zero mask coherent_dma_mask). As they have a of_node attached
> they will go through of_dma_configure, which will warn if it finds an
> uninitialized DMA mask. Let the driver core know that this isn't a
> missing configuration, but a non DMA capable device by pointing the
> dma_mask to the coherent_dma_mask.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

This fixes the following warnings seen on imx6q-sabresd:

[    1.323046] imx-pgc-pd imx-pgc-power-domain.0: DMA mask not set
[    1.323700] imx-pgc-pd imx-pgc-power-domain.1: DMA mask not set

Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
