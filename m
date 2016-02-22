From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 22 Feb 2016 16:45:10 +0530
Subject: [PATCH 0/2] Add Rockchip display port phy driver support
In-Reply-To: <1455534071-31230-1-git-send-email-ykk@rock-chips.com>
References: <1455534071-31230-1-git-send-email-ykk@rock-chips.com>
Message-ID: <56CAEDBE.2050808@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 15 February 2016 04:31 PM, Yakir Yang wrote:
> 
> Hi Kison,
> 
> This series is splited from Analogix DP DRM thread [0], and Heiko suggest this
> should be an independent thread which may be easy for you to apply.

Indeed. Merged now thanks. (Changed the year to 2016 in the file header before
merging)

Thanks
Kishon

> 
> Best regards,
> Yakir
> 
> [0]: https://patchwork.kernel.org/patch/8086571/
> 
> 
> Changes in v12:
> - Re-order the include headers file alphabetically in phy-rockchip-dp.c (Jingoo)
> 
> Changes in v11:
> - Correct the title of this rockchip dp phy document(Rob)
> - Add the ack from Rob Herring
> 
> Changes in v10:
> - Fix the wrong macro value of GRF_EDP_REF_CLK_SEL_INTER_HIWORD_MASK
>     BIT(4) -> BIT(20)
> 
> Changes in v9:
> - Removed the unused the variable "res" in probe function. (Heiko)
> - Removed the unused head file.
> 
> Changes in v8:
> - Fix the mixed spacers on macro definitions. (Heiko)
> - Remove the unnecessary empty line after clk_prepare_enable. (Heiko)
> - Remove the specific address in the example node name. (Heiko)
> 
> Changes in v7:
> - Simply the commit message. (Kishon)
> - Symmetrical enable/disbale the phy clock and power. (Kishon)
> - Simplify the commit message. (Kishon)
> 
> Changes in v5:
> - Remove "reg" DT property, cause driver could poweron/poweroff phy via
>   the exist "grf" syscon already. And rename the example DT node from
>   "edp_phy: phy at ff770274" to "edp_phy: edp-phy" directly. (Heiko)
> - Add deivce_node at the front of driver, update phy_ops type from "static
>   struct" to "static const struct". And correct the input paramters of
>   devm_phy_create() interfaces. (Heiko)
> - Split binding doc's from driver changes. (Rob)
> - Update the rockchip,grf explain in document, and correct the clock required
>   elemets in document. (Rob & Heiko)
> 
> Changes in v4:
> - Add commit message, and remove the redundant rockchip_dp_phy_init()
>   function, move those code to probe() method. And remove driver .owner
>   number. (Kishon)
> 
> Changes in v3:
> - Suggest, add rockchip dp phy driver, collect the phy clocks and
>   power control. (Heiko)
> 
> Yakir Yang (2):
>   phy: Add driver for rockchip Display Port PHY
>   dt-bindings: add document for rockchip dp phy
> 
>  .../devicetree/bindings/phy/rockchip-dp-phy.txt    |  22 +++
>  drivers/phy/Kconfig                                |   7 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/phy-rockchip-dp.c                      | 151 +++++++++++++++++++++
>  4 files changed, 181 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt
>  create mode 100644 drivers/phy/phy-rockchip-dp.c
> 
