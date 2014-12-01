From: dianders@chromium.org (Doug Anderson)
Date: Mon, 1 Dec 2014 14:19:38 -0800
Subject: [PATCH v10 4/4] ARM: dts: rockchip: add suspend settings for
 rk3288-evb-rk808
In-Reply-To: <1417423940-1669-5-git-send-email-zyw@rock-chips.com>
References: <1417423940-1669-1-git-send-email-zyw@rock-chips.com>
 <1417423940-1669-5-git-send-email-zyw@rock-chips.com>
Message-ID: <CAD=FV=XHUze3ovhFSN7_9rvM6tpKrF90ii1XbHPxw4q-7ob+dA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chris,

On Mon, Dec 1, 2014 at 12:52 AM, Chris Zhong <zyw@rock-chips.com> wrote:
> Add suspend-voltages and necessary pin-states for suspend on
> rk3288-evb-rk808 boards. global_pwroff would be pulled high when
> RK3288 entering suspend, this pin is a sleep signal for RK808, so
> RK808 could goto sleep mode, and some regulators would be disable.
>
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
>
> ---
>
> Changes in v10:
> - remove regulator-suspend-mem-enabled and regulator-suspend-mem-microvolt
> - enable the lcd, codec, sdmmc power during suspend
>
> Changes in v9:
> - update the subject and description
>
> Changes in v8:
> - keep all except cpu&tp power rail on during suspend
> - add regulator-on-in-suspend before set suspend voltage
> - add a reference of ddrio_pwroff and ddr0_retention
>
> Changes in v7:
> - add regulator-state-mem sub node for suspend
>
> Changes in v6: None
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
>
>  arch/arm/boot/dts/rk3288-evb-rk808.dts | 53 +++++++++++++++++++++++++++++++++-
>  1 file changed, 52 insertions(+), 1 deletion(-)

I'm still not 100% clear on why it wakes up by itself, but I guess (?)
that could be solved in a separate patch.  I did confirm that if I
hacked the wakeup source to be just from GPIOs that it stayed asleep
and could be awakened by the power button.  I tested on linux-next
with evb-rk808.

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>

-Doug
