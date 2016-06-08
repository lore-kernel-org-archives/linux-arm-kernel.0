From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 08 Jun 2016 14:26:51 +0200
Subject: [PATCH] spi: rockchip: Signal unfinished DMA transfers
In-Reply-To: <1465371171-20810-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1465371171-20810-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <3685265.1KrVuCJFto@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 8. Juni 2016, 09:32:51 schrieb Tomeu Vizoso:
> When using DMA, the transfer_one callback should return 1 because the
> transfer hasn't finished yet.
> 
> A previous commit changed the function to return 0 when the DMA channels
> were correctly prepared.
> 
> This manifested in Veyron boards with this message:
> 
> [ 1.983605] cros-ec-spi spi0.0: EC failed to respond in time
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Fixes: ea9849113343 ("spi: rockchip: check return value of
> dmaengine_prep_slave_sg")
> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>

looks like Mark already applied it, but nevertheless I was able to verify that 
this patch fixes the issue on my veyron jerry chromebook as well, so

Tested-by: Heiko Stuebner <heiko@sntech.de>
