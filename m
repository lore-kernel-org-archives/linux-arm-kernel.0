From: zhengxing@rock-chips.com (Xing Zheng)
Date: Tue, 10 Jan 2017 14:15:28 +0800
Subject: [PATCH v4 0/2] Add support rockchip,grf property for RK3399 PMU/GRU
Message-ID: <1484028930-20305-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,
  The structure rockchip_clk_provider needs to refer the GRF regmap
in somewhere, if the CRU node has not "rockchip,grf" property,
calling syscon_regmap_lookup_by_phandle will return an invalid GRF
regmap, and the MUXGRF type clock will be not supported.

Therefore, we need to add them.

Thanks.


Changes in v4:
- separte the binding patch
- update the decription for rockchip,grf property

Changes in v3:
- add optional roperty rockchip,grf in rockchip,rk3399-cru.txt

Changes in v2:
- referring pmugrf for PMUGRU
- fix the typo "invaild" in COMMIT message

Xing Zheng (2):
  arm64: dts: rockchip: add "rockchip, grf" property for RK3399
    PMUCRU/CRU
  dt-bindings: clk: add rockchip,grf property for RK3399

 Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.txt | 6 ++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi                        | 2 ++
 2 files changed, 8 insertions(+)

-- 
2.7.4
