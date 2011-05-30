From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 30 May 2011 15:08:17 +0530
Subject: [PATCH] ARM: EXYNOS4: Fix secondary CPU boot after wake-up
In-Reply-To: <1306746781-21511-1-git-send-email-inderpal.s@samsung.com>
References: <1306746781-21511-1-git-send-email-inderpal.s@samsung.com>
Message-ID: <4DE36589.4080709@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/30/2011 2:43 PM, Inderpal Singh wrote:
[...]

> 2. Fix to remove the "Unknown IPI message 0x1" message when
>     secondary CPU boots.
>
For this one you are avoiding a wakeup IPI and rather
relying on schedule IPI. That just avoiding the issue.

This doesn't seems to be right. Refer below thread.

http://www.spinics.net/lists/arm-kernel/msg110886.html

Russell,
When do you plan to fix the SGI usage as discussed
in above thread. I thought SGI1 usage was ok for OMAP,
realview/versatile and MSM.

Regards
Santosh
