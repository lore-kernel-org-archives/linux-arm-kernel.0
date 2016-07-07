From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 7 Jul 2016 15:45:40 +0200
Subject: [PATCH v4 1/2] ARM: cpuidle: fix !cpuidle_ops[cpu].init case
 during init
In-Reply-To: <1467785755-3488-2-git-send-email-jszhang@marvell.com>
References: <1467785755-3488-1-git-send-email-jszhang@marvell.com>
 <1467785755-3488-2-git-send-email-jszhang@marvell.com>
Message-ID: <20160707134540.GA20553@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2016 at 02:15:54PM +0800, Jisheng Zhang wrote:
> Let's assume cpuidle_ops exists but it doesn't implement the according
> init callback, current arm_cpuidle_init() will return success to its
> caller, but in fact it should return -EOPNOTSUPP.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
