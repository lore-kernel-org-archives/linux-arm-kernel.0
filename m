From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 8 Jun 2017 10:45:15 +0200
Subject: [PATCH 9/9] arm64: marvell: dts: add xmdio nodes for 7k/8k
In-Reply-To: <20170607083810.30922-10-antoine.tenart@free-electrons.com>
References: <20170607083810.30922-1-antoine.tenart@free-electrons.com>
 <20170607083810.30922-10-antoine.tenart@free-electrons.com>
Message-ID: <20170608084515.GA12385@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Wed, Jun 07, 2017 at 10:38:10AM +0200, Antoine Tenart wrote:
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> index 2a99ff8fca2a..594356243ddb 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> @@ -103,6 +103,13 @@
>  				clocks = <&cps_syscon0 1 9>, <&cps_syscon0 1 5>;
>  			};
>  
> +			cps_xmdio: mdio at 12a600 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "marvell,xmdio";
> +				reg = <0x12a600 0x10>;
> +			};
> +

Russell pointed out on IRC the mdio/xmdio interfaces aren't wired to
anything on the mcbin. We could either disable these interfaces by
default, or add explicit disables in the mcbin device tree.

What's your thoughts on this?

Thanks!
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170608/d6e8a142/attachment-0001.sig>
