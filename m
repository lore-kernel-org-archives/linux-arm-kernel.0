From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 13 Jun 2013 21:26:45 +0900
Subject: [RESEND PATCH 1/3] ARM: EXYNOS: Move arm core power down clock to
 exynos5250 common clock
In-Reply-To: <1370501833-9196-1-git-send-email-amit.daniel@samsung.com>
References: <1363240979-1939-2-git-send-email-amit.daniel@samsung.com>
 <1370501833-9196-1-git-send-email-amit.daniel@samsung.com>
Message-ID: <150e01ce6831$44d94920$ce8bdb60$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amit Daniel Kachhap wrote:
> 
> Now with common clock support added for exynos5250 it is necessary to move
> this code to exynos5250 common clock driver as clock registers should be
> handled there. This change is tested in exynos5250 based arndale platform.
> 
> Cc: Abhilash Kesavan <a.kesavan@samsung.com>
> Cc: Thomas Abraham <thomas.abraham@linaro.org>
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>

Hmm...I'm not sure it's better to handle the ARM core power down clock in
common clock but the clock registers should be handled in one part, clock.

Acked-by: Kukjin Kim <kgene.kim@samsugn.com>

Mike, the mach-exynos/cpuidle.c is not touched in samsung tree at this
moment, so this patch will not create any conflict between samsung and clk.

Thanks,
- Kukjin
