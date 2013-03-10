From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Sun, 10 Mar 2013 23:42:19 +0100
Subject: [PATCH V2 3/5] ARM: DT: tegra114:add aliases and DMA requestor
 for serial controller
In-Reply-To: <1362852678-13421-4-git-send-email-ldewangan@nvidia.com>
References: <1362852678-13421-1-git-send-email-ldewangan@nvidia.com>
 <1362852678-13421-4-git-send-email-ldewangan@nvidia.com>
Message-ID: <20130310224219.GG4743@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 09, 2013 at 11:41:16PM +0530, Laxman Dewangan wrote:
[...]
> diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
[...]
> @@ -99,38 +106,50 @@
>  		       0x70003000 0x40c>;	/* Mux registers */
>  	};
>  
> -	serial at 70006000 {
> +	/*
> +	 * There are two serial driver i.e. 8250 based simple serial
> +	 * driver and APB DMA based serial driver for higher baudrate
> +	 * and performace. To enable the 8250 based driver, the compatible
> +	 * is "nvidia,tegra114-uart", "nvidia,tegra20-uart" and to enable
> +	 * the APB DMA based serial driver, the comptible is
> +	 * "nvidia,tegra114-hsuart", "nvidia,tegra30-hsuart".
> +	 */
> +	uarta: serial at 70006000 {

I'm not sure if this is a good place for this comment. Perhaps it should
go into the binding documentation?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130310/1fc5f404/attachment.sig>
