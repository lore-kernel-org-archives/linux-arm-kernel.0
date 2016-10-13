From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 13 Oct 2016 14:25:34 +0200
Subject: [PATCH v2 1/2] clocksource: arm_arch_timer: Don't assume clock
 runs in suspend
In-Reply-To: <1475604730-140264-1-git-send-email-briannorris@chromium.org>
References: <1475604730-140264-1-git-send-email-briannorris@chromium.org>
Message-ID: <9d699d78-18cd-689f-02d4-529e10c7f2a0@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2016 20:12, Brian Norris wrote:
> The ARM ARM specifies that the system counter "must be implemented in an
> always-on power domain," and so we try to use the counter as a source of
> timekeeping across suspend/resume. Unfortunately, some SoCs (e.g.,
> Rockchip's RK3399) do not keep the counter ticking properly when
> switched from their high-power clock to the lower-power clock used in
> system suspend. Support this quirk by adding a new device tree property.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---

Both patches applied for 4.10.

Thanks !

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
