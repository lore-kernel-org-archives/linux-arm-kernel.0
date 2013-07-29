From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Mon, 29 Jul 2013 13:41:49 +0100
Subject: [PATCH 1/4] ARM: dove: add cpu device tree node
In-Reply-To: <1375100946-28521-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1375100946-28521-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1375100946-28521-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <51F6630D.5010603@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/07/13 13:29, Sebastian Hesselbarth wrote:
> This adds a node for the Marvell Sheeva PJ4A CPU found on Dove SoCs.
> While at it, also move the l2-cache node out of internal registers and
> consistently name different nodes.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/boot/dts/dove.dtsi |   52 ++++++++++++++++++++++++++-----------------
>  1 file changed, 32 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
> index 8d5be1e8..09d9710 100644
> --- a/arch/arm/boot/dts/dove.dtsi
> +++ b/arch/arm/boot/dts/dove.dtsi
> @@ -10,6 +10,23 @@
>  		gpio2 = &gpio2;
>  	};
>  
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu at 0 {
> +			compatible = "marvell,pj4a", "marvell,sheeva-v7";
> +			device_type = "cpu";
> +			next-level-cache = <&l2>;
> +			reg = <0>;
> +		};
> +	};
> +
> +	l2: l2-cache {
> +		compatible = "marvell,tauros2-cache";
> +		marvell,tauros2-cache-features = <0>;
> +	};
Hi Sebastian,

This is not entirely related to the patch but thought of checking with
you. I was trying to get info on L2 cache controller on Marvell SoCs,
mainly structure or way/set size. Is that something we can get
dynamically ? Some specification I referred said its integrated and some
said its separate(not unified). Basically I need information around
various L2 cache implementations(Tauros2/Feroceon) from Marvell.

Any pointers or contacts to get this information will be helpful.

Regards,
Sudeep
