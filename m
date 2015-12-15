From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 15 Dec 2015 21:42:20 +0100
Subject: [PATCH] clocksource/drivers/dw_apb_timer: Fix apbt_readl return
 types
In-Reply-To: <1448466083-5182-1-git-send-email-jszhang@marvell.com>
References: <1448466083-5182-1-git-send-email-jszhang@marvell.com>
Message-ID: <56707B2C.30501@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/2015 04:41 PM, Jisheng Zhang wrote:
> On Marvell BG4CT platform, we observed the __apbt_read_clocksource()
> return wrong value: Let's assume the APBTMR_N_CURRENT_VALUE value is
> 0xf0000000, we got 0xffffffff0fffffff, but it should be 0xfffffff.
>
> This issue should be common on all 64bit platforms. We fix the issue
> by letting aptb_readl() return u32. apbt_writel() is also updated
> to write u32 val rather than unsigned long.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---

Applied.

Thanks !

   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
