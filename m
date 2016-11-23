From: robh@kernel.org (Rob Herring)
Date: Wed, 23 Nov 2016 17:07:25 -0600
Subject: [PATCH 1/4] clocksource/drivers/arm_arch_timer: Don't assume
 clock runs in suspend
In-Reply-To: <1479807866-6957-1-git-send-email-daniel.lezcano@linaro.org>
References: <20161122094300.GA2017@mai>
 <1479807866-6957-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20161123230725.c3euemhmfnm3qjtn@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2016 at 10:44:21AM +0100, Daniel Lezcano wrote:
> From: Brian Norris <briannorris@chromium.org>
> 
> The ARM specifies that the system counter "must be implemented in an
> always-on power domain," and so we try to use the counter as a source of
> timekeeping across suspend/resume. Unfortunately, some SoCs (e.g.,
> Rockchip's RK3399) do not keep the counter ticking properly when
> switched from their high-power clock to the lower-power clock used in
> system suspend. Support this quirk by adding a new device tree property.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/arch_timer.txt | 5 +++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/clocksource/arm_arch_timer.c                 | 9 ++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
