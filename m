From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Jan 2013 10:38:15 +0000
Subject: [PATCH 2/2] arm: make return_address available for ARM_UNWIND
In-Reply-To: <1357207949-3349-2-git-send-email-kpark3469@gmail.com>
References: <1357207949-3349-1-git-send-email-kpark3469@gmail.com>
 <1357207949-3349-2-git-send-email-kpark3469@gmail.com>
Message-ID: <20130103103815.GL2631@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 03, 2013 at 07:12:29PM +0900, kpark3469 at gmail.com wrote:
> -#if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND)
> +#if defined(CONFIG_FRAME_POINTER) || defined(CONFIG_ARM_UNWIND)
>  /*
>   * return_address uses walk_stackframe to do it's work.  If both
>   * CONFIG_FRAME_POINTER=y and CONFIG_ARM_UNWIND=y walk_stackframe uses unwind
> - * information.  For this to work in the function tracer many functions would
> - * have to be marked with __notrace.  So for now just depend on
> - * !CONFIG_ARM_UNWIND.

So what have you done about the issue referred in this comment?  Or do you
believe that fixing warnings (even if they are explicit #warning statements)
is far more important than code being functionally correct?
