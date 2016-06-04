From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Sat, 4 Jun 2016 12:40:32 +0900
Subject: [PATCH v13 04/10] arm64: Blacklist non-kprobe-able symbol
In-Reply-To: <1464924384-15269-5-git-send-email-dave.long@linaro.org>
References: <1464924384-15269-1-git-send-email-dave.long@linaro.org>
 <1464924384-15269-5-git-send-email-dave.long@linaro.org>
Message-ID: <20160604124032.94ac1bb76fde6c661e1a47a5@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Thu,  2 Jun 2016 23:26:18 -0400
David Long <dave.long@linaro.org> wrote:

> From: Pratyush Anand <panand@redhat.com>
> 
> Add all function symbols which are called from do_debug_exception under
> NOKPROBE_SYMBOL, as they can not kprobed.

I see, but this patch should be applied after kprobes
are implemented on arm64.

And also, I have a comment below.

> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 5954881..4359ca8 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -563,6 +563,7 @@ asmlinkage void __exception do_sp_pc_abort(unsigned long addr,
>  	info.si_addr  = (void __user *)addr;
>  	arm64_notify_die("Oops - SP/PC alignment exception", regs, &info, esr);
>  }
> +NOKPROBE_SYMBOL(do_debug_exception)

This seems at wrong place. Please correct it in this patch.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
