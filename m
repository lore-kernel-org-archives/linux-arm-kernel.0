From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 12 Apr 2017 10:37:07 +0200
Subject: [PATCH 6/7] arm64: marvell: dts: enable the crypto engine on the
 Armada 8040 DB
In-Reply-To: <20170329124432.27457-7-antoine.tenart@free-electrons.com>
 (Antoine Tenart's message of "Wed, 29 Mar 2017 14:44:31 +0200")
References: <20170329124432.27457-1-antoine.tenart@free-electrons.com>
 <20170329124432.27457-7-antoine.tenart@free-electrons.com>
Message-ID: <87wpaqggy4.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,
 
 On mer., mars 29 2017, Antoine Tenart <antoine.tenart@free-electrons.com> wrote:

> Enable the cryptographic engine available in the CP110 master on the
> Armada 8040 DB. Do not enable the one in the CP110 salve for now, as we
> do not support multiple cryptographic engines yet.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>


Applied on mvebu/dt64

Thanks,

Gregory


> ---
>  arch/arm64/boot/dts/marvell/armada-8040-db.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> index 80e685e4235d..f6d808bced51 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> @@ -140,6 +140,10 @@
>  	phy-mode = "rgmii-id";
>  };
>  
> +&cpm_crypto {
> +	status = "okay";
> +};
> +
>  /* CON5 on CP1 expansion */
>  &cps_pcie2 {
>  	status = "okay";
> -- 
> 2.11.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
