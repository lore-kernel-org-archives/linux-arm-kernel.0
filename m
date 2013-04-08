From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 08 Apr 2013 12:32:29 -0600
Subject: [PATCH 3/3] ARM: dts: tegra: Add PCIe entry for cardhu
In-Reply-To: <1365435688-4179-3-git-send-email-jagarwal@nvidia.com>
References: <1365435688-4179-1-git-send-email-jagarwal@nvidia.com>
 <1365435688-4179-3-git-send-email-jagarwal@nvidia.com>
Message-ID: <51630D3D.2040709@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/2013 09:41 AM, Jay Agarwal wrote:
> Signed-off-by: Jay Agarwal <jagarwal@nvidia.com>
> 
> - Add PCIe node entry for cardhu
> - Enable only root port 2
> - Initialize regulators required for tegra30

Initialize isn't correct; this change makes no changes to any regulator;
it simply includes the required regulator properties in the new node.

I think you'd want to re-write this patch description as:

Enable the PCIe controller on Cardhu. Only port 2 is connected on this
board. It is connected to the Ethernet controller in the dock.

> diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi

> +	pcie-controller {
...
>  	serial at 70006000 {

It lookos like this node is added in the wrong place. Nodes should be
sorted based on reg property, and judging by the reg property for this
node in tegra30.dtsi in Thierry's branch, this should be the first node
in the Cardhu file.
