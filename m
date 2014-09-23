From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 23 Sep 2014 17:33:47 +0100
Subject: [PATCH v2] ARM: zImage: add support for ARMv7-M
In-Reply-To: <1411147367-26824-1-git-send-email-manabian@gmail.com>
References: <1411057343-20861-1-git-send-email-manabian@gmail.com>
 <1411147367-26824-1-git-send-email-manabian@gmail.com>
Message-ID: <20140923163347.GE6858@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 19, 2014 at 06:22:47PM +0100, Joachim Eastwood wrote:
>  		.align
> -		.arm				@ Always enter in ARM state
> + AR_CLASS(	.arm	)		@ Always enter in ARM state for AR class

Nitpick: A/R class (or classes).

> +#elif defined(CONFIG_CPU_V7M)
> +		ldr	r9, =0xe000ed00		@ CPUID register address

Another nitpick: can you use some macro? We define them in
arch/arm/include/asm/v7m.h, so you could write the above as (untested):

		ldr	r9, =BASEADDR_V7M_SCB + V7M_SCB_CPUID

-- 
Catalin
