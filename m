From: marex@denx.de (Marek Vasut)
Date: Wed, 26 Aug 2015 16:39:02 +0200
Subject: [PATCH linux-next v5 3/5] mtd: spi-nor: allow to tune the number
 of dummy cycles
In-Reply-To: <4324f398c0e69e3057e7da6a1a3e0328b44f224f.1440580764.git.cyrille.pitchen@atmel.com>
References: <cover.1440580764.git.cyrille.pitchen@atmel.com>
 <4324f398c0e69e3057e7da6a1a3e0328b44f224f.1440580764.git.cyrille.pitchen@atmel.com>
Message-ID: <201508261639.02377.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, August 26, 2015 at 02:30:25 PM, Cyrille Pitchen wrote:
> The number of dummy cycles used during Fast Read commands can be reduced
> to improve transfer performances. Each manufacturer has a dedicated set of
> registers to provide the memory with the exact number of dummy cycles it
> should expect. Both the memory and the (Q)SPI controller must agree on
> this number of dummy cycles.
> 
> The number of dummy cycles can be found into the memory datasheet and
> mostly depends on the SPI clock frequency, the Fast Read op code and the
> Single/Dual Data Rate mode.
> 
> Probing JEDEC Serial Flash Discoverable Parameters (SFDP) tables would
> only provide the driver with a high enough number of dummy cycles for each
> Fast Read command to be used for all clock frequencies: this solution
> would not be optimized.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>

Acked-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
