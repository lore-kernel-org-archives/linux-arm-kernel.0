From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 22 Aug 2012 14:45:18 -0600
Subject: [PATCH v2 7/9] ARM: mvebu: Add pinctrl support to Armada XP SoCs
In-Reply-To: <1345623750-10645-8-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1345623750-10645-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1345623750-10645-8-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <503544DE.20003@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/2012 02:22 AM, Sebastian Hesselbarth wrote:
> This commits adds the necessary device tree information to define the
> compatible property for the pinctrl driver instance of Armada XP SoCs.
> 
> Until now, the device tree representation considered the Armada XP as
> a single SoC. But in fact, there are three different SoCs in the
> Armada XP families, with different number of CPU cores, different
> number of Ethernet interfaces... and different number of muxable pins
> or functions. We therefore introduce three armada-xp-mv78xx0.dtsi for
> the three SoCs of the Armada XP family. The current armada-xp-db.dts
> evaluation board uses the MV78460 variant of the SoC.

> diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi

> +/include/ "armada-xp.dtsi"
> +
> +/ {
> +	model = "Marvell Armada XP family SoC";
> +	compatible = "marvell,armadaxp-mv78230", "marvell,armadaxp", "marvell,armada-370-xp";

Since each of these files is specifically for a different SoC, I'd
expect them all to say something different in the model property?

> diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi

> +	model = "Marvell Armada XP family SoC";
> +	compatible = "marvell,armadaxp-mv78260", "marvell,armadaxp", "marvell,armada-370-xp";

> diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi

> +	model = "Marvell Armada XP family SoC";
> +	compatible = "marvell,armadaxp-mv78460", "marvell,armadaxp", "marvell,armada-370-xp";
