From: dianders@chromium.org (Doug Anderson)
Date: Tue, 2 Aug 2016 17:49:24 -0700
Subject: [PATCH] clk: rockchip: rk3399: add pll up and down when change
 pll freq
In-Reply-To: <1470143599-8851-1-git-send-email-zhengxing@rock-chips.com>
References: <1470143599-8851-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <CAD=FV=X1ZAhzBrFukvE9BxdFmgo8dj4GKjZ9EmPLTagHfO-ufg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Xing,

On Tue, Aug 2, 2016 at 6:13 AM, Xing Zheng <zhengxing@rock-chips.com> wrote:
> From: Elaine Zhang <zhangqing@rock-chips.com>
>
> The suggestion that is from IC designer, the correct pll sequence setting
> should be like these:
> ----
>   set pll to slow mode or other plls
>   set pll down
>   set pll params
>   set pll up
>   wait pll lock status
>   set pll to normal mode
> ----
>
> Hence, there are potential risks that we need to fix:
> rockchip_rk3399_wait_pll_lock - timeout waiting for pll to lock
> rockchip_rk3399_pll_set_params - pll update unsucessful, trying to restore old params

I still don't understand how that groks with the statement in the TRM:

> In most cases the PLL programming can be changed on-the-fly and the PLL will simply slew to the new frequency

That makes it sound like these PLLs are super great at dynamic updates.
