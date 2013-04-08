From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 08 Apr 2013 12:21:47 -0600
Subject: [PATCH 1/3] ARM: tegra: pcie: Add tegra3 support
In-Reply-To: <1365435688-4179-1-git-send-email-jagarwal@nvidia.com>
References: <1365435688-4179-1-git-send-email-jagarwal@nvidia.com>
Message-ID: <51630ABB.1020200@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/2013 09:41 AM, Jay Agarwal wrote:
> Signed-off-by: Jay Agarwal <jagarwal@nvidia.com>
> 
> - Enable pcie root port 2 for cardhu
> - Make private data structure for each SOC
> - Add required tegra3 clocks and regulators
> - Add tegra3 specific code in enable controller
> - Modify clock tree to get clocks based on device
> - Based on git://gitorious.org/thierryreding/linux.git

A couple more points on this patch:

* You didn't mention that this series is based on Thierry's
work-in-progress tree, and not something immediately destined for
upstream. As such, only Thierry is expected to actually apply any of
these patches.

* Your changes to the Tegra PCIe driver require that device tree include
extra clocks and regulators. You need to update
Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt to
describe these new requirements.
