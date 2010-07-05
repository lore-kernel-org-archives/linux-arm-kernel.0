From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 05 Jul 2010 13:13:04 +0100
Subject: [patch 2/2] arm: Implement l2x0 cache disable functions
In-Reply-To: <20100705113227.750612927@linutronix.de>
References: <20100705113029.082013074@linutronix.de>
	<20100705113227.750612927@linutronix.de>
Message-ID: <1278331984.11315.30.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-07-05 at 12:52 +0100, Thomas Gleixner wrote:
> Add flush_all, inv_all and disable functions to the l2x0 code. These
> functions are called from kexec code to prevent random crashes in the
> new kernel.
> 
> Platforms like OMAP which control L2 enable/disable via SMI mode can
> override the outer_cache.disable() function to implement their own.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[...]
> -static inline void l2x0_inv_all(void)
> +static void l2x0_flush_all(void)
> +{
> +       unsigned long flags;
> +
> +       /* clean all ways */

Minor point - /* clean and invalidate all ways */

But the patch looks good to me:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
