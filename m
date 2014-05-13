From: rric@kernel.org (Robert Richter)
Date: Tue, 13 May 2014 16:55:26 +0200
Subject: [PATCH 2/7] ARM: Introduce arm_get_current_stack_frame()
In-Reply-To: <1399974418-4995-3-git-send-email-Nikolay.Borisov@arm.com>
References: <1399974418-4995-1-git-send-email-Nikolay.Borisov@arm.com>
 <1399974418-4995-3-git-send-email-Nikolay.Borisov@arm.com>
Message-ID: <20140513145526.GX32718@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.05.14 10:46:53, Nikolay Borisov wrote:
>  #define instruction_pointer(regs)	(regs)->ARM_pc
> +#define frame_pointer(regs)				\
> +	IS_ENABLED(CONFIG_THUMB2_KERNEL) ? regs->ARM_r7 \
> +	: regs->ARM_fp					\

(regs)->... should be used here both.

-Robert
