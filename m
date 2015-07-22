From: marex@denx.de (Marek Vasut)
Date: Wed, 22 Jul 2015 15:43:54 +0200
Subject: [PATCH v2 2/5] Documentation: mtd: add a DT property to set the
 number of dummy cycles
In-Reply-To: <8119e3b46b91e43c10466b2400c6938a113b1c02.1437569902.git.cyrille.pitchen@atmel.com>
References: <cover.1437569902.git.cyrille.pitchen@atmel.com>
 <8119e3b46b91e43c10466b2400c6938a113b1c02.1437569902.git.cyrille.pitchen@atmel.com>
Message-ID: <201507221543.54761.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 22, 2015 at 03:17:07 PM, Cyrille Pitchen wrote:
> Depending on the SPI clock frequency, the Fast Read op code and the
> Single/Dual Data Rate mode, the number of dummy cycles can be tuned to
> improve transfer speed.
> The actual number of dummy cycles is specific for each memory model and is
> provided by the manufacturer thanks to the memory datasheet.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> ---
>  Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
> b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt index
> 2bee68103b01..4387567d8024 100644
> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
> @@ -19,6 +19,11 @@ Optional properties:
>                     all chips and support for it can not be detected at
> runtime. Refer to your chips' datasheet to check if this is supported by
> your chip.
> +- m25p,num-dummy-cycles : Set the number of dummy cycles for Fast Read
> commands. +                          Depending on the manufacturer
> additional dedicated +                          commands are sent to the
> flash memory so the +                          controller and the memory
> can agree on the number of +                          dummy cycles to use.

Can't you just try negotiating this value at probe time, starting with some
high value and see how low you can get with the negotiations ? This way, you'd 
be able to effectively auto-detect this value at probe-time.

I might be wrong though :)

Best regards,
Marek Vasut
