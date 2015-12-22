From: ralf@linux-mips.org (Ralf Baechle)
Date: Tue, 22 Dec 2015 02:16:09 +0100
Subject: [PATCH v2 9/9] MIPS: dts: jz4780/ci20: Add compatible property
 to "partitions" node
In-Reply-To: <1450694033-27717-10-git-send-email-geert+renesas@glider.be>
References: <1450694033-27717-1-git-send-email-geert+renesas@glider.be>
 <1450694033-27717-10-git-send-email-geert+renesas@glider.be>
Message-ID: <20151222011609.GA15881@linux-mips.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 21, 2015 at 11:33:53AM +0100, Geert Uytterhoeven wrote:
> Date:   Mon, 21 Dec 2015 11:33:53 +0100
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> To: arm at kernel.org, Andrew Lunn <andrew@lunn.ch>, Gregory Clement
>  <gregory.clement@free-electrons.com>, Sebastian Hesselbarth
>  <sebastian.hesselbarth@gmail.com>, Simon Horman <horms@verge.net.au>,
>  Magnus Damm <magnus.damm@gmail.com>, Ralf Baechle <ralf@linux-mips.org>,
>  Alex Smith <alex.smith@imgtec.com>
> Cc: Brian Norris <computersforpeace@gmail.com>, Rob Herring
>  <robh+dt@kernel.org>, devicetree at vger.kernel.org,
>  linux-arm-kernel at lists.infradead.org, linux-sh at vger.kernel.org,
>  linux-mips at linux-mips.org, linux-mtd at lists.infradead.org,
>  linux-kernel at vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
> Subject: [PATCH v2 9/9] MIPS: dts: jz4780/ci20: Add compatible property to
>  "partitions" node
> 
> As of commit e488ca9f8d4f62c2 ("doc: dt: mtd: partitions: add compatible
> property to "partitions" node"), the "partitions" subnode of an SPI
> FLASH device node must have a compatible property. The partitions are no
> longer detected if it is not present.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - New.
> ---
>  arch/mips/boot/dts/ingenic/ci20.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
> index 782258c0e4fbba8e..1652d8d60b1e4b86 100644
> --- a/arch/mips/boot/dts/ingenic/ci20.dts
> +++ b/arch/mips/boot/dts/ingenic/ci20.dts
> @@ -70,6 +70,7 @@
>  			nand-on-flash-bbt;
>  
>  			partitions {
> +				compatible = "fixed-partitions";
>  				#address-cells = <2>;
>  				#size-cells = <2>;
>  
> -- 
> 1.9.1

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
