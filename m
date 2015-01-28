From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 28 Jan 2015 15:31:49 -0600
Subject: [PATCH v10 1/3] arm64: Add __NR_* definitions for compat syscalls
In-Reply-To: <1404458911-8214-2-git-send-email-takahiro.akashi@linaro.org>
References: <1404458911-8214-1-git-send-email-takahiro.akashi@linaro.org>
 <1404458911-8214-2-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <CAOZdJXUhpmi0SM5izDYQnx8SHjWjqOFVduV0+boPw6+YCKP5+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 4, 2014 at 2:28 AM, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
> +#define __ARM_NR_COMPAT_BASE           0x0f0000
> +#define __ARM_NR_compat_cacheflush     (__ARM_NR_COMPAT_BASE+2)
> +#define __ARM_NR_compat_set_tls                (__ARM_NR_COMPAT_BASE+5)

I know this patch is six months old, but I was wondering if anyone
knows of any plans to make these syscalls available to 64-bit apps?
We have a 32-bit app that uses __ARM_NR_compat_cacheflush, and we'd
like to port that app to 64-bit.  I'm just not sure how to start doing
that, since there don't appear to be any 64-bit ARM-specific syscalls.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
