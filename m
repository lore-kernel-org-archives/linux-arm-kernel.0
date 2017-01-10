From: dianders@google.com (Doug Anderson)
Date: Mon, 9 Jan 2017 19:06:16 -0800
Subject: [PATCH v3] arm64: dts: rockchip: add "rockchip, grf" property for
 RK3399 PMUCRU/CRU
In-Reply-To: <1484011661-13474-1-git-send-email-zhengxing@rock-chips.com>
References: <1484011661-13474-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <CAD=FV=UsMR=HD5799N7ny_Ce8XXCkcd3R3tpX34AEC6UmGkXtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 9, 2017 at 5:27 PM, Xing Zheng <zhengxing@rock-chips.com> wrote:
> The structure rockchip_clk_provider needs to refer the GRF regmap
> in somewhere, if the CRU node has not "rockchip,grf" property,
> calling syscon_regmap_lookup_by_phandle will return an invalid GRF
> regmap, and the MUXGRF type clock will be not supported.
>
> Therefore, we need to add them.
>
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> ---
>
> Changes in v3:
> - add optional roperty rockchip,grf in rockchip,rk3399-cru.txt
>
> Changes in v2:
> - referring pmugrf for PMUGRU
> - fix the typo "invaild" in COMMIT message
>
>  Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.txt | 5 +++++
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi                        | 2 ++

"dts" and bindings shouldn't change in the same patch since they go
through different trees.  This is why I said:

> This looks sane to me, but before you land it you need to first send
> up a (separate) patch that adjusts:
>       --------

AKA: you need a two patch series here.

Sometimes it's OK to include bindings together with code changes
(depends on the maintainer), but never with dts changes.

-Doug
