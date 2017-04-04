From: hpa@zytor.com (H. Peter Anvin)
Date: Tue, 4 Apr 2017 11:11:03 -0700
Subject: [PATCH v6 2/4] x86/syscalls: Specific usage of
 verify_pre_usermode_state
In-Reply-To: <20170404174727.35478-2-thgarnie@google.com>
References: <20170404174727.35478-1-thgarnie@google.com>
 <20170404174727.35478-2-thgarnie@google.com>
Message-ID: <b2b1b4fe-18ea-7643-09c0-312fd8f4b4d8@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/17 10:47, Thomas Garnier wrote:
> Implement specific usage of verify_pre_usermode_state for user-mode
> returns for x86.
> 
> Signed-off-by: Thomas Garnier <thgarnie@google.com>
>  
> +	/*
> +	 * If address limit is not based on user-mode, jump to slow path for
> +	 * additional security checks.
> +	 */
> +	movq	$TASK_SIZE_MAX, %rcx
> +	cmp	%rcx, TASK_addr_limit(%r11)
> +	jnz	1f
> +
>  	LOCKDEP_SYS_EXIT

Nitpick: use jne not jnz when comparing for equality.  Same instruction
but more readable.

	-hpa
