From: sjg@chromium.org (Simon Glass)
Date: Sat, 25 Jun 2016 20:54:02 -0600
Subject: [PATCH] pci: tegra: actually program REFCLK_CFG* on recent SoCs
In-Reply-To: <20160624143703.13231-1-swarren@wwwdotorg.org>
References: <20160624143703.13231-1-swarren@wwwdotorg.org>
Message-ID: <CAPnjgZ05T4+wEH4WwP4c_QWjwFvU6=3j4d+GnzqvpwJ3o5R3Bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 June 2016 at 08:37, Stephen Warren <swarren@wwwdotorg.org> wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> On recent SoCs, tegra_pcie_phy_enable() isn't called; but instead
> tegra_pcie_enable_controller() calls tegra_xusb_phy_enable(). However,
> part of tegra_pcie_phy_enable() needs to happen in all cases. Move that
> code to tegra_pcie_port_enable() instead.
>
> For reference, NVIDIA's downstream Linux kernel performs this operation
> in tegra_pcie_enable_rp_features(), which is called immediately after
> tegra_pcie_port_enable(). Since that function doesn't exist in the mainline
> driver, we'll just add it to the tail of tegra_pcie_port_enable() instead.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  drivers/pci/host/pci-tegra.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
