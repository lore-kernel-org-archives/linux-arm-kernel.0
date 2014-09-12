From: dianders@chromium.org (Doug Anderson)
Date: Fri, 12 Sep 2014 16:52:40 -0700
Subject: [PATCH v2 4/7] clk: rockchip: make tightly bound armclk
 child-clocks read-only
In-Reply-To: <1410561030-19127-5-git-send-email-heiko@sntech.de>
References: <1410561030-19127-1-git-send-email-heiko@sntech.de>
 <1410561030-19127-5-git-send-email-heiko@sntech.de>
Message-ID: <CAD=FV=W3Ua5VSQxHXyCBkAjhToUFcNEgmqQm4=50RzCk0ft9Yg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Fri, Sep 12, 2014 at 3:30 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> Rockchip SoCs contain clocks tightly bound to the armclk, where the best
> rate / divider is supplied by the vendor after careful measuring.
> Often this ideal rate may be greater than the current rate.
>
> Therefore prevent the ccf from trying to set these dividers itself by
> setting them to read-only.
>
> In the case of the rk3066, this also includes the aclk_cpu, which makes it
> necessary to also split its direct child-clocks (pclk_cpu, hclk_cpu, ...)
> into individual definitions for rk3066 and rk3188.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/clk/rockchip/clk-rk3188.c | 26 ++++++++++++++++++--------
>  drivers/clk/rockchip/clk-rk3288.c | 18 +++++++++---------
>  2 files changed, 27 insertions(+), 17 deletions(-)

This seems pretty reasonable to me.  I only glanced at rk3188 / rk3066
code quickly, but for rk3288 I can say:

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
