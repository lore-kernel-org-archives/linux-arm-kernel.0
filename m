From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Wed, 30 Sep 2015 08:26:23 -0700
Subject: [PATCH 2/2] clocksource/drivers/keystone: Fix bad NO_IRQ usage
In-Reply-To: <1443607710-10415-2-git-send-email-daniel.lezcano@linaro.org>
References: <560BB452.1020000@linaro.org>
 <1443607710-10415-1-git-send-email-daniel.lezcano@linaro.org>
 <1443607710-10415-2-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <560BFF1F.6000201@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/30/2015 3:08 AM, Daniel Lezcano wrote:
> The current code assumes the 'irq_of_parse_and_map' will return NO_IRQ in case
> of failure. Unfortunately, the NO_IRQ is not consistent across the different
> architectures and we must not rely on it.
>
> NO_IRQ is equal to '-1' on ARM and 'irq_of_parse_and_map' returns '0' in case
> of an error. Hence, the latter won't be detected and will lead to a crash.
>
> Fix this by just checking 'irq' is different from zero.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/clocksource/timer-keystone.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
