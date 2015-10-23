From: dianders@chromium.org (Doug Anderson)
Date: Fri, 23 Oct 2015 08:25:50 -0700
Subject: [PATCH v4 2/3] thermal: rockchip: support the sleep pinctrl state
 to avoid glitches in s2r
In-Reply-To: <1445599528-18825-3-git-send-email-wxt@rock-chips.com>
References: <1445599528-18825-1-git-send-email-wxt@rock-chips.com>
 <1445599528-18825-3-git-send-email-wxt@rock-chips.com>
Message-ID: <CAD=FV=X2fCoQFU9sXT5tRtAt-oebkh=TCWrf74jHHrZNTV_nmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Caesar,

On Fri, Oct 23, 2015 at 4:25 AM, Caesar Wang <wxt@rock-chips.com> wrote:
> When we come out of system suspend state (S3) the tsadc will have been
> reset and back at its default state.  While reprogramming the tsadc
> it's possible that we'll glitch the output and unintentionally cause
> the "over temperature" GPIO to be asserted.  Since the over
> temperature GPIO is often hooked up to something that will cause a
> reboot or shutdown in hardware, this glitch can be catastrophic on
> some boards.
>
> We'll add support for selecting the "sleep" pinctrl state at suspend
> time.  Boards can use this to effectively disable the tsadc at suspend
> time and avoid glitches when the system is resumed.
>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>
> ---
>
> Changes in v4:
>   - take the Doug's commit as correct decription.
>
> Changes in v3:
>   - Add the pinctrl state for in the suspend/resume.
>
> Changes in v2: None
> Changes in v1: None
>
>  drivers/thermal/rockchip_thermal.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
