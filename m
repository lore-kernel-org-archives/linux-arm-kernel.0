From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 19 May 2011 09:36:58 +0100
Subject: [PATCH 1/1] ARM: thumb: Have the machine name indicate operation
	in thumb mode.
In-Reply-To: <20110518223319.GB21384@n2100.arm.linux.org.uk>
References: <20110513195316.9AD0940CD1@eskimo.mtv.corp.google.com>
	<BANLkTikhRuk2ZfYjriTcP7oFdbr7h1oP5g@mail.gmail.com>
	<20110514100232.GC30539@n2100.arm.linux.org.uk>
	<20110516121657.GA7715@arm.com>
	<alpine.LFD.2.00.1105161008320.14430@xanadu.home>
	<20110516144311.GC7715@arm.com>
	<BANLkTik0LL+dFCo_H-YhF+BUOXyP7MAKzA@mail.gmail.com>
	<alpine.LFD.2.00.1105181803090.14430@xanadu.home>
	<20110518223319.GB21384@n2100.arm.linux.org.uk>
Message-ID: <20110519083658.GA2431@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 18, 2011 at 11:33:19PM +0100, Russell King - ARM Linux wrote:

[...]

> We already have a way of adding stuff for bug tracking purposes.  The
> "Internal error" line is perpended with 'PREEMPT' or 'SMP' depending
> on what build options were enabled.  We just need to do the same with
> T2.  IOW, something like this:
> 
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index 3b54ad1..78d7714 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -225,6 +225,11 @@ void show_stack(struct task_struct *tsk, unsigned long *sp)
>  #else
>  #define S_SMP ""
>  #endif
> +#ifdef CONFIG_THUMB2_KERNEL
> +#define S_ISA " T2"

Just for consistency, can I suggest that if this is implemented, we
make the string " thumb2"? (upper case optional)  This matches what
we now put in MODULE_ARCH_VERMAGIC, as well as being closer to the
CONFIG_ name.

Cheers
---Dave
