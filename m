From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 13 Oct 2016 11:21:40 +0100
Subject: [PATCH v2 1/2] clocksource: arm_arch_timer: Don't assume clock
 runs in suspend
In-Reply-To: <1475604730-140264-1-git-send-email-briannorris@chromium.org>
References: <1475604730-140264-1-git-send-email-briannorris@chromium.org>
Message-ID: <20161013112140.6f71fec7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  4 Oct 2016 11:12:09 -0700
Brian Norris <briannorris@chromium.org> wrote:

> The ARM ARM specifies that the system counter "must be implemented in an
> always-on power domain," and so we try to use the counter as a source of
> timekeeping across suspend/resume. Unfortunately, some SoCs (e.g.,
> Rockchip's RK3399) do not keep the counter ticking properly when
> switched from their high-power clock to the lower-power clock used in
> system suspend. Support this quirk by adding a new device tree property.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
