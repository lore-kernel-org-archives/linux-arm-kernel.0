From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 1 Mar 2018 08:43:56 +0800
Subject: [PATCH] ARM: dts: mx5: Pass the memory unit-address
In-Reply-To: <1519784015-16507-1-git-send-email-festevam@gmail.com>
References: <1519784015-16507-1-git-send-email-festevam@gmail.com>
Message-ID: <20180301004354.GO3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 27, 2018 at 11:13:35PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Pass the memory unit-address to fix the following build warnings with W=1:
> 
> arch/arm/boot/dts/imx51-zii-rdu1.dtb: Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
> arch/arm/boot/dts/imx53-tx53-x03x.dtb: Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
> arch/arm/boot/dts/imx53-tx53-x13x.dtb: Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
> 
> In theses cases an empty memory node is passed, which will be filled
> by the bootloader. Passing the memory base address still allows the
> bootloader to fill the memory size.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

s/mx5/imx5 in subject.

I fixed it up and applied the patch.

Shawn
