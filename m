From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 3 Feb 2016 11:27:31 -0600
Subject: [PATCH v10 5/5] Watchdog: ARM SBSA Generic Watchdog half timeout
 panic support
In-Reply-To: <1454519923-25230-6-git-send-email-fu.wei@linaro.org>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
 <1454519923-25230-6-git-send-email-fu.wei@linaro.org>
Message-ID: <56B23883.7000501@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fu.wei at linaro.org wrote:
> +#ifdef CONFIG_ARM_SBSA_WATCHDOG_PANIC
> +static bool panic_enabled = true;

I think this should default to 'false', because IMHO, this seems like an 
odd feature.  I'm not crazy about the fact that there's a Kconfig option 
for it either, but I'm not going to NACK this patch.

I personally would prefer to drop this patch, and just wait for 
full-blown pre-timeout support.  It feels like a debugging feature that 
doesn't really belong upstream.  But like I said, it's just my opinion, 
and I won't complain if I'm outvoted.
