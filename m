From: dianders@google.com (Doug Anderson)
Date: Mon, 9 Jan 2017 10:52:29 -0800
Subject: [PATCH v2] arm64: dts: rockchip: add "rockchip, grf" property for
 RK3399 PMUCRU/CRU
In-Reply-To: <1483945344-3125-1-git-send-email-zhengxing@rock-chips.com>
References: <1483945344-3125-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <CAD=FV=WjzU_2QSLET3Y9_5A5khXjqMYNzB2ifextKhekmvCsjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jan 8, 2017 at 11:02 PM, Xing Zheng <zhengxing@rock-chips.com> wrote:
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
> Changes in v2:
> - referring pmugrf for PMUGRU
> - fix the typo "invaild" in COMMIT message
>
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 2 ++
>  1 file changed, 2 insertions(+)

This looks sane to me, but before you land it you need to first send
up a (separate) patch that adjusts:

Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.txt

...it would also be sorta nice if you included an a patch in your
series that actually uses this new functionality.


-Doug
