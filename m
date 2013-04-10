From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 10 Apr 2013 16:30:37 -0600
Subject: [PATCH] ARM: tegra: Add charger subnode to tps65090 node
In-Reply-To: <1365623505-6309-1-git-send-email-rklein@nvidia.com>
References: <1365623505-6309-1-git-send-email-rklein@nvidia.com>
Message-ID: <5165E80D.7050106@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2013 01:51 PM, Rhyland Klein wrote:
> The charger is now represented by a distinct subnode of the tps65090
> device. Add this node and enable low current charging with it.

> diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts

> +			charger {
> +				compatible = "ti,tps65090-charger";
> +				ti,enable-low-current-chrg;

So does the TPS65090 driver scan all its sub-nodes like a bus an
instantiate anything? That's a little odd since the regulators node is
at the same level, yet doesn't represent a device on that same internal
bus...
