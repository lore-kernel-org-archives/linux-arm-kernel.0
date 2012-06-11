From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 11 Jun 2012 15:41:46 -0600
Subject: [PATCH v2 09/10] ARM: tegra: harmony: Initialize PCIe from DT
In-Reply-To: <1339427118-32263-10-git-send-email-thierry.reding@avionic-design.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <1339427118-32263-10-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <4FD6661A.1060407@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2012 09:05 AM, Thierry Reding wrote:
> With the device tree support in place, probe the PCIe controller from
> the device tree and remove the corresponding workaround in the board
> file.

> diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts

> +	pci_vdd_reg: fixedregulator at 0 {

I think that'd usually just be "regulator at 0".

If you need the "@0" part to differentiate between multiple regulators,
the node needs a reg property too:

	reg = <0 0>;

although then I wonder about putting the regulator under the root node,
since the address wouldn't really make sense...
