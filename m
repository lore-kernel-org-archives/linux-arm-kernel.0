From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 15 Jan 2018 16:00:45 -0500 (EST)
Subject: [PATCH v3 0/8] ARM: sun9i: SMP and CPU hotplug support
In-Reply-To: <20180115071450.18355-1-wens@csie.org>
References: <20180115071450.18355-1-wens@csie.org>
Message-ID: <nycvar.YSQ.7.76.1801151502050.13881@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Jan 2018, Chen-Yu Tsai wrote:

> Changes since v2:
>   - Do away with the MCPM framework, directly implement smp_ops
>   - Some debug messages were clarified
>   - New ARCH_SUNXI_MCPM Kconfig symbol for this feature

You should use ARCH_SUNXI_SMP instead to avoid confusion with the actual 
MCPM code. Ditto for function names as Dave mentioned.

For the ARM to Thumb switch you could add something like this at the 
beginning of your entry code:

#ifdef CONFIG_THUMB2_KERNEL
	.arm
	mov	ip, #1
	bx	ip
	.thumb
#endif
	[your code follows here]

And make sure that code is word aligned.


Nicolas
