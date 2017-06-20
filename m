From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 20 Jun 2017 15:35:53 +0200
Subject: [PATCH] arm64: dts: marvell: mcbin: enable the mdio node
In-Reply-To: <20170619073729.8367-1-antoine.tenart@free-electrons.com>
 (Antoine Tenart's message of "Mon, 19 Jun 2017 09:37:29 +0200")
References: <20170619073729.8367-1-antoine.tenart@free-electrons.com>
Message-ID: <87o9ti4w92.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,
 
 On lun., juin 19 2017, Antoine Tenart <antoine.tenart@free-electrons.com> wrote:

> Since the mdio nodes are disabled by default now, we should explicitly
> enable these nodes at the board level when they are used. Enable the
> cpm_mdio node for the 8040-mcbin.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Applied on mvebu/dt64

Thanks,

Gregory
> ---
>
> Hi Gregory,
>
> The series disabling the mdio nodes at the SoC level forgot to enable
> the cpm_mdio node for the 8040-mcbin. This is based on mvebu/dt64.
>
> Thanks,
> Antoine
>
>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> index fe56efcfcefe..4968e731de61 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> @@ -116,6 +116,8 @@
>  };
>  
>  &cpm_mdio {
> +	status = "okay";
> +
>  	ge_phy: ethernet-phy at 0 {
>  		reg = <0>;
>  	};
> -- 
> 2.9.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
