From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 06 Apr 2011 22:35:31 -0700
Subject: [PATCH v3] ARM: Use generic BUG() handler
In-Reply-To: <1302131890-20953-1-git-send-email-sjg@chromium.org>
References: <1302131890-20953-1-git-send-email-sjg@chromium.org>
Message-ID: <4D9D4D23.6000805@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/6/2011 4:18 PM, Simon Glass wrote:
> v3: Remove old BUG() implementation in favor of this one.
> Remove the Backtrace: message (will submit this separately).
> Use ARM_EXIT_KEEP() so that some architectures can dump exit text at link time
> thanks to Stephen Boyd <sboyd@codeaurora.org> (although since we always
> define GENERIC_BUG this might be academic.)

Its not entirely academic because CONFIG_BUG=n and CONFIG_SMP_ON_UP=n
would allow us to remove the exit text. This could be huge for people
who want to cram kernel's onto space constrained devices.

> Rebase to linux-2.6.git master.
>
> Change-Id: I07d77c832e816f5ad2390e25f466ddf750adecf4

Don't forget to remove these before submitting to the patch tracker (and
sending to the list).

> diff --git a/arch/arm/include/asm/bug.h b/arch/arm/include/asm/bug.h
> index 4d88425..2914724 100644
> --- a/arch/arm/include/asm/bug.h
> +++ b/arch/arm/include/asm/bug.h
> @@ -3,21 +3,58 @@
>  
>  
>  #ifdef CONFIG_BUG
> -#ifdef CONFIG_DEBUG_BUGVERBOSE
> -extern void __bug(const char *file, int line) __attribute__((noreturn));
> -
> -/* give file/line information */
> -#define BUG()		__bug(__FILE__, __LINE__)

Does anybody reference __bug() anymore? If not you can remove that too.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
