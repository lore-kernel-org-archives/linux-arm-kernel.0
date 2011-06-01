From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Jun 2011 10:34:36 +0100
Subject: [PATCH] arm: fix lockdep warning of "unannotated irqs-off"
In-Reply-To: <20110601154259.12487694@tom-ThinkPad-T410>
References: <20110601154259.12487694@tom-ThinkPad-T410>
Message-ID: <20110601093436.GF3660@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2011 at 03:42:59PM +0800, Ming Lei wrote:
> @@ -435,6 +435,10 @@ __irq_usr:
>  	usr_entry
>  	kuser_cmpxchg_check
>  
> +#ifdef CONFIG_TRACE_IRQFLAGS

I think this wants to be CONFIG_IRQSOFF_TRACER.
