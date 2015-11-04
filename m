From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Nov 2015 10:23:27 +0000
Subject: [PATCH 2/4] arm: add implementation for arm-smccc
In-Reply-To: <1446630372-1598-3-git-send-email-jens.wiklander@linaro.org>
References: <1446630372-1598-1-git-send-email-jens.wiklander@linaro.org>
 <1446630372-1598-3-git-send-email-jens.wiklander@linaro.org>
Message-ID: <20151104102327.GJ8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 04, 2015 at 10:46:10AM +0100, Jens Wiklander wrote:
> +	.macro SMCCC instr
> +	mov	r12, sp
> +	push	{r4-r7}
> +	ldm	r12, {r4-r7}
> +	\instr
> +	pop	{r4-r7}
> +	ldr	r12, [sp, #(4 * 4)]
> +	stm	r12, {r0-r3}
> +	bx	lr
> +	.endm

Please add unwinding support to this.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
