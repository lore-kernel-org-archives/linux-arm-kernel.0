From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 15 Jun 2017 10:15:58 +0200
Subject: [PATCH] arm64: dts: marvell: enable the cpm crypto engine on the
 mcbin
In-Reply-To: <20170615080150.27534-1-antoine.tenart@free-electrons.com>
 (Antoine Tenart's message of "Thu, 15 Jun 2017 10:01:50 +0200")
References: <20170615080150.27534-1-antoine.tenart@free-electrons.com>
Message-ID: <87zid97jk1.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,
 
 On jeu., juin 15 2017, Antoine Tenart <antoine.tenart@free-electrons.com> wrote:

> This patch enables the cpm crypto engine on the mcbin.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

as this controller is always present and dot not depend on any
pinmux configuration, could you enable it at SoC level?

Thanks,

Gregory

> ---
>
> Hi Gregory,
>
> This patch applies on top of today's mvebu/dt64 branch.
>
> Thanks!
> Antoine
>
>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> index fe56efcfcefe..2556c8268b40 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> @@ -176,3 +176,7 @@
>  	usb-phy = <&usb3h0_phy>;
>  	status = "okay";
>  };
> +
> +&cpm_crypto {
> +	status = "okay";
> +};
> -- 
> 2.9.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
