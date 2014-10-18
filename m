From: dianders@chromium.org (Doug Anderson)
Date: Fri, 17 Oct 2014 17:57:20 -0700
Subject: [PATCH v2 2/4] ARM: rockchip: add suspend and resume for RK3288
In-Reply-To: <1413578830-26220-1-git-send-email-zyw@rock-chips.com>
References: <1413578696-26125-1-git-send-email-zyw@rock-chips.com>
 <1413578830-26220-1-git-send-email-zyw@rock-chips.com>
Message-ID: <CAD=FV=W__U7+YQkxQmt1BRkuNvfqMmdTJe-cT3iy6i7uCbaK=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chris,

On Fri, Oct 17, 2014 at 1:47 PM,  <zyw@rock-chips.com> wrote:
> From: Chris Zhong <zyw@rock-chips.com>
>
> It's a basic version of suspend and resume for rockchip, it only support RK3288
> now.
>
> Signed-off-by: Tony Xie <xxx@rock-chips.com>
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
>
> ---
>
> Changes in v2:
> - add the regulator calls in prepare and finish.
> - add the pinmux of gpio6_c6 save and restore

I'm a bit out of time to do a real review right now, but I would have
expected that the pinmux stuff:

* was saved and restored in the pinmux driver.

* was in a separate patch, before this one in the series.


The pinmux driver should have callbacks for saving and restoring
pinmux state, so you should use those.  Maybe exynos_pinctrl_suspend()
is an example, though you only need to save one pin.  You should
probably also explain that only gpio6_c6 needs to be saved and
restored since the MaskROM clobbers it upon resume.

-Doug
