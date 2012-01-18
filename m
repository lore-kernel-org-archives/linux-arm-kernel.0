From: rob.lee@linaro.org (Rob Lee)
Date: Wed, 18 Jan 2012 05:40:02 -0600
Subject: [RFC PATCH v3] ARM: imx: Add basic imx6q thermal management
In-Reply-To: <1326862087-17816-2-git-send-email-rob.lee@linaro.org>
References: <1326862087-17816-1-git-send-email-rob.lee@linaro.org>
 <1326862087-17816-2-git-send-email-rob.lee@linaro.org>
Message-ID: <CAMXH7KE3CUvoZgW2UQiPLc3-oAHO0gcH4GRHU46ScyK519nvfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> + ? ? ? /* In the rarest of cases, order matters here - resume goes first */
> + ? ? ? th_zone->therm_dev->device.class->resume = imx6q_thermal_resume;
> + ? ? ? th_zone->therm_dev->device.class->suspend = imx6q_thermal_suspend;
On second thought, I should have barrier between these two statements
to guarantee order.  I think mb() would be ok.
