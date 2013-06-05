From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 05 Jun 2013 10:36:01 -0600
Subject: [PATCH V4 2/4] ARM: tegra: pcie: Add tegra3 support
In-Reply-To: <1370445221-17696-1-git-send-email-jagarwal@nvidia.com>
References: <1370445221-17696-1-git-send-email-jagarwal@nvidia.com>
Message-ID: <51AF68F1.8080307@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2013 09:13 AM, Jay Agarwal wrote:
> - Make private data structure for each SoC
> - Add required Tegra30 clocks and regulators
> - Add Tegra30 specific code in enable controller
> - Added Tegra30 specific properties in pci binding document

It's a bit odd to send an updated version of just some of the patches;
reposting a whole series is much easier for the person applying the
patches. However, hopefully Thierry can handle it in this case.

> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt

>  Required properties:
> -- compatible: "nvidia,tegra20-pcie"
> +- compatible: "nvidia,tegra20-pcie" "nvidia,tegra30-pcie"

perhaps add "or" between those two entries?

> +- avdd-supply: Power supply for controller (1.05V) (not required for tegra20)
...
> +  "cml": The Tegra clock of that name (not required for tegra20)

Tegra20 should be capitalized in both those two lines.

I assume that Thierry can fix up these nits when he applies the patches,
so you don't need to repost. Thierry can correct me if I'm wrong.
