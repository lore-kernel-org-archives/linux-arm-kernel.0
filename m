From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 18 May 2017 14:41:16 +0100
Subject: [RFC PATCH 6/7] ARM: V7M: Add support for MPU to M-class
In-Reply-To: <1495030735-22078-7-git-send-email-vladimir.murzin@arm.com>
References: <1495030735-22078-1-git-send-email-vladimir.murzin@arm.com>
 <1495030735-22078-7-git-send-email-vladimir.murzin@arm.com>
Message-ID: <f81a054d-90ec-1a0a-c294-30695a24cccb@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/05/17 15:18, Vladimir Murzin wrote:
>  	/* Enable the MPU */
> -	mrc	p15, 0, r0, c1, c0, 0		@ Read SCTLR
> +AR_CLASS(mrc	p15, 0, r0, c1, c0, 0)		@ Read SCTLR
> +M_CLASS(ldr	r0, [r12, MPU_CTRL])
>  	bic	r0, r0, #CR_BR			@ Disable the 'default mem-map'
                       ^^^^^^^
There is a mistake, for M-class it should be #(1 << 2). I'll re-spin.

Cheers
Vladimir

>  	orr	r0, r0, #CR_M			@ Set SCTRL.M (MPU on)
> -	mcr	p15, 0, r0, c1, c0, 0		@ Enable MPU
> +AR_CLASS(mcr	p15, 0, r0, c1, c0, 0)		@ Enable MPU
> +M_CLASS( str	r0, [r12, MPU_CTRL])
