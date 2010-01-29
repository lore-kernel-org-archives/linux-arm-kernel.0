From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 29 Jan 2010 07:45:01 +0100
Subject: [RFC PATCH 06/12] arm: msm: set L2CR1 to enable prefetch and
	burst on Scorpion.
In-Reply-To: <1264719577-5436-7-git-send-email-dwalker@codeaurora.org>
References: <1264719577-5436-7-git-send-email-dwalker@codeaurora.org>
Message-ID: <20100129064501.GB1347@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> From: Larry Bassel <lbassel@quicinc.com>
> 
> This change improves the following LMBench benchmarks
> by over 15%:

But what does this change do?

> @@ -242,6 +243,10 @@ __v7_setup:
>  	mcr	p15, 0, r4, c2, c0, 1		@ load TTB1
>  	mov	r10, #0x1f			@ domains 0, 1 = manager
>  	mcr	p15, 0, r10, c3, c0, 0		@ load domain access register
> +#ifdef CONFIG_ARCH_MSM_SCORPION
> +	mov     r0, #0x77
> +	mcr     p15, 3, r0, c15, c0, 3          @ set L2CR1
> +#endif

...probably should be explained here...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
