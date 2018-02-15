From: horms@verge.net.au (Simon Horman)
Date: Thu, 15 Feb 2018 16:16:44 +0100
Subject: [PATCH v2 2/2] arm64: dts: renesas: eagle: specify EtherAVB PHY
 IRQ
In-Reply-To: <0ccd631e-691a-2b15-7680-6e0c847a6ca2@cogentembedded.com>
References: <038a791d-aa57-9c3d-eaea-09c5704ecb54@cogentembedded.com>
 <0ccd631e-691a-2b15-7680-6e0c847a6ca2@cogentembedded.com>
Message-ID: <20180215151644.szxwehuu6b7w5uuv@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 13, 2018 at 02:24:14PM +0300, Sergei Shtylyov wrote:
> Specify  EtherAVB PHY IRQ  in the Eagle board's device tree, now that we
> have the GPIO support (previously phylib had to resort to polling).
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks, applied with Geert's tag.

> ---
>  arch/arm64/boot/dts/renesas/r8a77970-eagle.dts |    2 ++
>  1 file changed, 2 insertions(+)
> 
> Index: renesas/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> ===================================================================
> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> +++ renesas/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> @@ -44,6 +44,8 @@
>  	phy0: ethernet-phy at 0 {
>  		rxc-skew-ps = <1500>;
>  		reg = <0>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <17 IRQ_TYPE_LEVEL_LOW>;

Could you consider following-up with a patch to add:

		reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;

>  	};
>  };
>  
> 
