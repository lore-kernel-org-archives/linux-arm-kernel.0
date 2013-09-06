From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 06 Sep 2013 23:12:05 +0100
Subject: [PATCH 1/5] arm: LLVMLinux: Add current_stack_pointer macro for
 ARM
In-Reply-To: <1378502899-1241-2-git-send-email-behanw@converseincode.com>
 (behanw@converseincode.com's message of "Fri, 6 Sep 2013 17:28:07
 -0400")
References: <1378502899-1241-1-git-send-email-behanw@converseincode.com>
 <1378502899-1241-2-git-send-email-behanw@converseincode.com>
Message-ID: <yw1xmwnp1txm.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

behanw at converseincode.com writes:

> +#define current_stack_pointer ({ \
> +	unsigned long current_sp; \
> +	asm ("mov %0, r13" : "=r" (current_sp)); \
> +	current_sp; \
> +})

Why do you use 'r13' rather than the more common 'sp' alias?

-- 
M?ns Rullg?rd
mans at mansr.com
