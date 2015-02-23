From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 23 Feb 2015 17:13:34 +0000
Subject: [PATCHv2 05/15] ARM: mvebu: add stdout-path to all armada-*.dts
In-Reply-To: <1424451874-25375-6-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1424451874-25375-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1424451874-25375-6-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20150223171334.GP9714@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 20, 2015 at 05:04:24PM +0000, Thomas Petazzoni wrote:
> This commit adds the stdout-path property in /chosen for all Armada
> boards that were not yet carrying this property.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-370-db.dts              | 1 +
>  arch/arm/boot/dts/armada-370-mirabox.dts         | 1 +
>  arch/arm/boot/dts/armada-370-netgear-rn102.dts   | 1 +
>  arch/arm/boot/dts/armada-370-netgear-rn104.dts   | 1 +
>  arch/arm/boot/dts/armada-370-rd.dts              | 1 +
>  arch/arm/boot/dts/armada-375-db.dts              | 1 +
>  arch/arm/boot/dts/armada-388-db.dts              | 1 +
>  arch/arm/boot/dts/armada-388-rd.dts              | 1 +
>  arch/arm/boot/dts/armada-xp-axpwifiap.dts        | 1 +
>  arch/arm/boot/dts/armada-xp-db.dts               | 1 +
>  arch/arm/boot/dts/armada-xp-gp.dts               | 1 +
>  arch/arm/boot/dts/armada-xp-matrix.dts           | 1 +
>  arch/arm/boot/dts/armada-xp-netgear-rn2120.dts   | 1 +
>  arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 1 +
>  14 files changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
> index e993c46..286bedd 100644
> --- a/arch/arm/boot/dts/armada-370-db.dts
> +++ b/arch/arm/boot/dts/armada-370-db.dts
> @@ -56,6 +56,7 @@
>  
>  	chosen {
>  		bootargs = "console=ttyS0,115200 earlyprintk";
> +		stdout-path = &uart0;

stdout-path can now take a config too (including the rate), which will
avoid any reliance on the serial core choosing the right rate by
default.

If you have an alias serial0, this could be:

	stdout-path = "serial0:115200n8";

Otherwise you can use the full path instead of serial0.

That's documented in Documentation/devicetree/bindings/chosen.txt

Mark.
