From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 4 Oct 2013 18:08:46 -0400
Subject: [RFC PATCH v2] ARM: OMAP4/highbank: Flush L2 cache before
 disabling
In-Reply-To: <1380920277-31622-1-git-send-email-taras.kondratiuk@linaro.org>
References: <1380920277-31622-1-git-send-email-taras.kondratiuk@linaro.org>
Message-ID: <524F3C6E.4070700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 October 2013 04:57 PM, Taras Kondratiuk wrote:
> Kexec disables outer cache before jumping to reboot code, but it doesn't
> flush it explicitly. Flush is done implicitly inside of l2x0_disable().
> But some SoC's override default .disable handler and don't flush cache.
> This may lead to a corrupted memory during Kexec reboot on these platforms.
> 
> This patch adds cache flush inside of OMAP4 and Highbank outer_cache.disable()
> handlers to make it consistent with default l2x0_disable().
> Also it removes redundant outer_flush_all() call just before outer_disable().
> 
> Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
> ---
> v2: Make the fix specific to platforms that don't use l2x0_disable().
> v1: https://patchwork.kernel.org/patch/2974431/
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
