From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 08 Mar 2012 14:31:41 -0700
Subject: [PATCH 11/11] ARM: tegra: pcie: Add device tree support
In-Reply-To: <1331218291-16119-12-git-send-email-thierry.reding@avionic-design.de>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-12-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <4F59253D.7070100@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2012 07:51 AM, Thierry Reding wrote:
> This commit adds support for instantiating the Tegra PCIe controller
> from a device tree.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>

> diff --git a/Documentation/devicetree/bindings/pci/tegra-pcie.txt b/Documentation/devicetree/bindings/pci/tegra-pcie.txt

> +NVIDIA Tegra PCIe controller
> +
> +Required properties:
> +- compatible: "nvidia,tegra20-pcie"
> +- reg: physical base address and length of the controller's registers
> +- interrupts: the interrupt outputs of the controller
> +
> +Optional properties:
> +- pex-clk-supply: supply voltage for internal reference clock
> +- vdd-supply: power supply for controller (1.05V)

Mark, Liam,

Should those *-supply properties really be optional? I got the
impression talking to Mark in a different thread that all regulators
should exist, although their implementation may be via a fixed
regulator, with no GPIO, as determined by the board design.
