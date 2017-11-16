From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 16 Nov 2017 15:36:05 +0800
Subject: [PATCH v5] ARM: dts: imx53-tx53: Fix 'ethernet-phy@0' node with
 unit name and no reg property
In-Reply-To: <1509031514-30602-1-git-send-email-marco.franchi@nxp.com>
References: <1509031514-30602-1-git-send-email-marco.franchi@nxp.com>
Message-ID: <20171116073604.GB25384@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 26, 2017 at 01:25:14PM -0200, Marco Franchi wrote:
> The following build warning is seen with W=1:
> 
> Warning (unit_address_vs_reg): Node /soc/aips at 60000000/ethernet at 63fec000/ethernet-phy at 0 has a unit name, but no reg property
> 
> Fix this warning by adding reg property from such node and, consequently, 
> includes a mdio node into the fec node, with the 'address-cells' and 
> 'size-cells' to avoid these other following warnings:
> 
> Warning (reg_format): "reg" property in /soc/aips at 60000000/ethernet at 63fec000/ethernet-phy at 0 has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
> Warning (avoid_default_addr_size): Relying on default #address-cells value for /soc/aips at 60000000/ethernet at 63fec000/ethernet-phy at 0
> Warning (avoid_default_addr_size): Relying on default #size-cells value for /soc/aips at 60000000/ethernet at 63fec000/ethernet-phy at 0
> 
> Signed-off-by: Marco Franchi <marco.franchi@nxp.com>

Applied, thanks.
