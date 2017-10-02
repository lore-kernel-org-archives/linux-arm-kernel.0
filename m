From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 02 Oct 2017 16:23:43 +0200
Subject: [PATCH v2 2/2] dt-bindings: i2c: Update documentation for
 "mv78230-a0-i2c"
In-Reply-To: <20170928213605.22874-3-kalyan.kinthada@alliedtelesis.co.nz>
 (Kalyan Kinthada's message of "Fri, 29 Sep 2017 10:36:05 +1300")
References: <20170928213605.22874-1-kalyan.kinthada@alliedtelesis.co.nz>
 <20170928213605.22874-3-kalyan.kinthada@alliedtelesis.co.nz>
Message-ID: <87k20dmxw0.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,
 
 On ven., sept. 29 2017, Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz> wrote:

> This commit modifies the documentation for
> "marvell,mv78230-a0-i2c" compatible string.
>
> The "marvell,mv78230-a0-i2c" compatible string enables the workaround
> for an i2c repeated start timing violation, but unlike
> "marvell,mv78230-i2c" it disables the i2c offload support. This is
> applicable to a number of SoCs such as early revisions of the Armada XP
> and the Armada 38x.
>
> Signed-off-by: Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz>


I applied the dt fix on my mvebu/fixes branch. Do you want to apply this
one on your branch, or do you prefer I take it. In this case an acked-by
would be nice.

Thanks,

Gregory


> ---
>  Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> index 5c30026921ae..c6cbab17ed0a 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> @@ -10,10 +10,12 @@ Required properties :
>                       - "marvell,mv64xxx-i2c"
>                       - "marvell,mv78230-i2c"
>                       - "marvell,mv78230-a0-i2c"
> -                       * Note: Only use "marvell,mv78230-a0-i2c" for a
> -                         very rare, initial version of the SoC which
> -                         had broken offload support.  Linux
> -                         auto-detects this and sets it appropriately.
> +                       * Note: Use "marvell,mv78230-a0-i2c" for
> +                         controller which do not support offload
> +                         but still have the i2c repeated start
> +                         timing violation issue, such as the
> +                         ones found in the Armada XP A0 and the
> +                         Armada 38x SoCs.
>   - interrupts      : The interrupt number
>  
>  Optional properties :
> -- 
> 2.14.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
