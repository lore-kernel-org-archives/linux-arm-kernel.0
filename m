From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 12 Aug 2014 12:38:12 -0700
Subject: [PATCH v3 5/7] arm: kgdb: Handle read-only text / modules
In-Reply-To: <1407867869-5194-6-git-send-email-keescook@chromium.org>
References: <1407867869-5194-1-git-send-email-keescook@chromium.org>
 <1407867869-5194-6-git-send-email-keescook@chromium.org>
Message-ID: <53EA6D24.3000609@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/14 11:24, Kees Cook wrote:
> @@ -244,6 +248,32 @@ void kgdb_arch_exit(void)
>  	unregister_die_notifier(&kgdb_notifier);
>  }
>  
> +int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
> +{
> +	int err;
> +
> +	/* patch_text() only supports int-sized breakpoints */
> +	if (sizeof(int) != BREAK_INSTR_SIZE)
> +		return -EINVAL;

Could this be a BUILD_BUG_ON too?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
