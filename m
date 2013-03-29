From: florian@openwrt.org (Florian Fainelli)
Date: Fri, 29 Mar 2013 19:25:30 +0100
Subject: [PATCH 1/4] mv643xx_eth: add Device Tree bindings
In-Reply-To: <1364580879-4297-2-git-send-email-florian@openwrt.org>
References: <1364580879-4297-1-git-send-email-florian@openwrt.org>
 <1364580879-4297-2-git-send-email-florian@openwrt.org>
Message-ID: <5155DC9A.6050806@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 03/29/13 19:14, Florian Fainelli a ?crit :
> This patch adds Device Tree bindings following the already defined
> bindings at Documentation/devicetree/bindings/marvell.txt. The binding
> documentation is also enhanced with new optionnal properties required
> for supporting certain devices (RX/TX queue and SRAM). Since we now have
> proper support for the orion MDIO bus driver, there is no need to fiddle
> around with device tree phandles.
>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---

[snip]

>
> -	return 0;
> +	return of_platform_bus_probe(np, mv643xx_eth_match, &pdev->dev);

This breaks on non-OF builds, I will wait for more comments to show up 
and fix this in the next round.
--
Florian
