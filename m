From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 28 Sep 2017 09:56:38 +0200
Subject: [PATCH 2/2] dt-bindings: i2c: Update documentation for
 "mv78230-a0-i2c"
In-Reply-To: <20170928040407.8933-3-kalyan.kinthada@alliedtelesis.co.nz>
 (Kalyan Kinthada's message of "Thu, 28 Sep 2017 17:04:07 +1300")
References: <20170928040407.8933-1-kalyan.kinthada@alliedtelesis.co.nz>
 <20170928040407.8933-3-kalyan.kinthada@alliedtelesis.co.nz>
Message-ID: <87wp4jgssp.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kalyan,
 
 On jeu., sept. 28 2017, Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz> wrote:

> This commit modifies the documentation for
> "marvell,mv78230-a0-i2c" compatible string.
>
> The "marvell,mv78230-a0-i2c" compatible string enables the workaround
> for an i2c repeated start timing violation, but unlike
> "marvell,mv78230-i2c" it disables the i2c offload support. This is
> applicable to a number of SoCs such as early revisions of the Armada XP
> and the Armada 38x.
>
> Deleted the special note for "marvell,mv78230-a0-i2c" as it can
> be used by other SoCs as well.
>
> Signed-off-by: Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> index 5c30026921ae..37c00ad1c0bb 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> @@ -10,10 +10,6 @@ Required properties :
>                       - "marvell,mv64xxx-i2c"
>                       - "marvell,mv78230-i2c"
>                       - "marvell,mv78230-a0-i2c"
> -                       * Note: Only use "marvell,mv78230-a0-i2c" for a
> -                         very rare, initial version of the SoC which
> -                         had broken offload support.  Linux
> -                         auto-detects this and sets it appropriately.

I think here we should pour more details like what you wrote in the
commit log. Maybe something like:

                        - "marvell,mv78230-a0-i2c": for controller which
                          do not support offload but still have the i2c
                          repeated start timing violation issue, such as
                          the ones found in the Armada XP A0 and the
                          Armada 38x SoCs.


And I still have to check it for Armada 375 and Armada 39x, but of
course it is not preventing merging your patches.

Gregory




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
