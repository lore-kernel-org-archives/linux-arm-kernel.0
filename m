From: dianders@chromium.org (Doug Anderson)
Date: Mon, 10 Nov 2014 10:40:14 -0800
Subject: [PATCH v7 4/5] ARM: dts: add RK3288 suspend support
In-Reply-To: <1415368177-6637-5-git-send-email-zyw@rock-chips.com>
References: <1415368177-6637-1-git-send-email-zyw@rock-chips.com>
 <1415368177-6637-5-git-send-email-zyw@rock-chips.com>
Message-ID: <CAD=FV=Uur0za+NX-vKWhPq61JFBwFRHu2MNFeaLQmpsZbs87dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chris,

On Fri, Nov 7, 2014 at 5:49 AM, Chris Zhong <zyw@rock-chips.com> wrote:
> add pmu sram node for suspend, add global_pwroff pinctrl.
> The pmu sram is used to store the resume code.
> global_pwroff is held low level at work, it would be pull to high
> when entering suspend. reference this in the board DTS file since
> some boards need it.
>
> Signed-off-by: Tony Xie <xxx@rock-chips.com>
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Tested-by: Doug Anderson <dianders@chromium.org>
>
> ---
>
> Changes in v7: None
> Changes in v6:
> - change pmu_intmem at ff720000 to sram at ff720000
>
> Changes in v5:
> - change size to 4k
>
> Changes in v4: None
> Changes in v3: None
> Changes in v2:
> - put "rockchip,rk3288-pmu-sram" to first
>
>  arch/arm/boot/dts/rk3288.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)

I was sorta hoping that when you sent out v7 you'd incorporate the
extra dts bits that you sent me and that I had stashed at
<https://chromium-review.googlesource.com/#/c/226826/>.  Maybe you
could do it if you send out a v8.

If you don't send out a v8 we could always land those bits separately.

-Doug
