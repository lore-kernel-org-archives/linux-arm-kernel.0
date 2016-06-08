From: robh@kernel.org (Rob Herring)
Date: Wed, 8 Jun 2016 14:14:06 -0500
Subject: [v1 PATCH 1/4] Documentation: bindings: add dt doc for Rockchip
 USB Type-C PHY
In-Reply-To: <57577719.9020400@rock-chips.com>
References: <1464966911-18949-1-git-send-email-zyw@rock-chips.com>
 <1464966911-18949-2-git-send-email-zyw@rock-chips.com>
 <20160606142738.GA12472@rob-hp-laptop>
 <57561653.9060404@rock-chips.com>
 <CAL_Jsq+7fNuL3N24uh+F_VgGU0RBGUn_nwRA3_cFBseaobpqDw@mail.gmail.com>
 <57577719.9020400@rock-chips.com>
Message-ID: <20160608191406.GA16940@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 09:38:33AM +0800, Chris Zhong wrote:
> Hi Rob
> 
> On 06/07/2016 09:46 PM, Rob Herring wrote:
> >On Mon, Jun 6, 2016 at 7:33 PM, Chris Zhong <zyw@rock-chips.com> wrote:
> >>Hi Rob
> >>
> >>
> >>On 06/06/2016 10:27 PM, Rob Herring wrote:
> >>>On Fri, Jun 03, 2016 at 11:15:08PM +0800, Chris Zhong wrote:
> >>>>This patch adds a binding that describes the Rockchip USB Type-C PHY
> >>>>for rk3399
> >>>>
> >>>>Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> >>>>
> >>>>---
> >>>>
> >>>>Changes in v1:
> >>>>- add extcon node description
> >>>>- move the registers in phy driver
> >>>>- remove the suffix of reset
> >>>>
> >>>>   .../devicetree/bindings/phy/phy-rockchip-typec.txt | 46
> >>>>++++++++++++++++++++++
> >>>>   1 file changed, 46 insertions(+)
> >>>>   create mode 100644
> >>>>Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> >>>>
> >>>>diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> >>>>b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> >>>>new file mode 100644
> >>>>index 0000000..964e0f7
> >>>>--- /dev/null
> >>>>+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> >>>>@@ -0,0 +1,46 @@
> >>>>+* ROCKCHIP type-c PHY
> >>>>+---------------------
> >>>>+
> >>>>+Required properties:
> >>>>+ - compatible: should be "rockchip,rk3399-typec-phy0" or
> >>>>+                        "rockchip,rk3399-typec-phy1"
> >>>What's the difference between 0 and 1? If it is to handle the register
> >>>offsets you have in the previous version and the phy blocks are
> >>>identical, then the compatible strings should be the same.
> >>yes, the registers are different between 0 and 1, and there is a grf
> >>register(0x6268) for switch the phy 0 and phy 1
> >But GRF is in a separate block and not part of the phy, right?
> >
> >Rob
> The GRF is not a single function block, it contain many registers to control
> other block.
> For Type-c phy, the type-c orientation, phy select, and some phy status
> registers are embedded in GRF
> So the GRF is registered for a syscon driver, the phy driver call regmap to
> access the registers.

Right, so different compatible strings is wrong here. Keep it more like 
you had it before.

Rob
