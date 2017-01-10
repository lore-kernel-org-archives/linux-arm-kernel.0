From: dianders@google.com (Doug Anderson)
Date: Mon, 9 Jan 2017 19:08:32 -0800
Subject: [PATCH v3] arm64: dts: rockchip: add "rockchip, grf" property for
 RK3399 PMUCRU/CRU
In-Reply-To: <1484011661-13474-1-git-send-email-zhengxing@rock-chips.com>
References: <1484011661-13474-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <CAD=FV=XWWt4tfEh0x7pHiCz8mzag3NLBzPO1Z9EPMQ=TxAK5Yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 9, 2017 at 5:27 PM, Xing Zheng <zhengxing@rock-chips.com> wrote:
> +Optional Properties:
> +
> +- rockchip,grf: phandle to the syscon managing the "general register files"
> +  If missing pll rates are not changable, due to the missing pll lock status.

On rk3399 the GRF isn't used for pll lock status.  It's used for PLL muxes.

...so technically if you don't include it then the PLL muxes won't be
changeable.  Hopefully the code handles this if the property is listed
as "Optional".  ...and unless Heiko says otherwise, you probably need
to list it as "Optional" since (presumably) there might be backward
compatibility issues.

-Doug
