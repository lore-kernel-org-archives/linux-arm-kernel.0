From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 15 Mar 2011 22:35:50 +0900
Subject: [PATCH 0/2] ARM: EXYNOS4: Enhancement of System MMU
In-Reply-To: <1299460768-4077-1-git-send-email-pullip.cho@samsung.com>
References: <1299460768-4077-1-git-send-email-pullip.cho@samsung.com>
Message-ID: <011701cbe315$e9677140$bc3653c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

KyongHo Cho wrote:
> 
> This patch includes the following enhancements for System MMU:
> - Enhanced readability
> - Removal of unused data structures or their members
> - Simplified function definitions
> - Corrections of some logical errors
> - Full compliance with Linux coding style
> - Simpler way of registering callback functions of System MMU faults
> - Add clock gating for System MMU
> 
> [PATCH 1/2] ARM: EXYNOS4: Enhancement of System MMU driver
> [PATCH 2/2] ARM: EXYNOS4: Implement Clock gating for System MMU

Cc'ed Marek.

As I said before, Marek's SystemMMU driver has some problems.

One is that it allocates 4MB virtual memory at once. It is really a problem
because, the device memory manager must knows the peculiarity and handles
it. Otherwise, page tables can be overwritten...

Anyway, I think Marek's initial idea is good esp., clock handling.
But now, this looks better for its enhancement and as we know if required,
we can improve this later.

Applied, thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
