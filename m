From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 16 Aug 2013 21:38:50 +0530
Subject: [PATCH v5 1/2] ARM: davinci: da850: add DT node for ethernet
In-Reply-To: <1376662262-21795-2-git-send-email-prabhakar.csengg@gmail.com>
References: <1376662262-21795-1-git-send-email-prabhakar.csengg@gmail.com>
 <1376662262-21795-2-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <520E4E92.7070902@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/16/2013 7:41 PM, Lad, Prabhakar wrote:
> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
> 
> Add ethernet device tree node information and pinmux for mii to da850 by
> providing interrupt details and local mac address.
> 
> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> ---
>  arch/arm/boot/dts/da850-evm.dts |    5 +++++
>  arch/arm/boot/dts/da850.dtsi    |   30 ++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
> index 1f8cfdd..44f3fbc 100644
> --- a/arch/arm/boot/dts/da850-evm.dts
> +++ b/arch/arm/boot/dts/da850-evm.dts
> @@ -96,6 +96,11 @@
>  			pinctrl-0 = <&mdio_pins>;
>  			bus_freq = <2200000>;
>  		};
> +		ethernet: emac at 1e20000 {

You misunderstood what Sergei said. This should be:

	eth0: ethernet at 1e20000 {

Thanks,
Sekhar
