From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 27 Feb 2013 10:26:08 +0530
Subject: [PATCH 4/4] ARM: timer-sp: Set dynamic irq affinity
In-Reply-To: <1361917047-29230-5-git-send-email-daniel.lezcano@linaro.org>
References: <1361917047-29230-1-git-send-email-daniel.lezcano@linaro.org>
 <1361917047-29230-5-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <512D91E8.6050706@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 February 2013 03:47 AM, Daniel Lezcano wrote:
> From: Viresh Kumar <viresh.kumar@linaro.org>
>
> When a cpu goes to a deep idle state where its local timer is shutdown, it
> notifies the time frame work to use the broadcast timer instead.
>
> Unfortunately, the broadcast device could wake up any CPU, including an idle one
> which is not concerned by the wake up at all.
>
Broad-cast device will only open the CPU for which the timer IRQ
affined to. And infact with subject series the affinity also is
updated for the CPU which owns the last timer expiry event.

> This implies, in the worst case, an idle CPU will wake up to send an IPI to
> another idle cpu.
>
> This patch fixes this for ARM platforms using timer-sp, by setting
> CLOCK_EVT_FEAT_DYNIRQ feature.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
What am I missing here ?

Regards,
Santosh
