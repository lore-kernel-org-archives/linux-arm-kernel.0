From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 15 Feb 2014 23:17:19 -0300
Subject: [PATCH v2 06/23] ARM: Kirkwood: ioremap the cpu_config register
 before using it.
In-Reply-To: <1392459621-24003-7-git-send-email-andrew@lunn.ch>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
 <1392459621-24003-7-git-send-email-andrew@lunn.ch>
Message-ID: <20140216021718.GA8926@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Sat, Feb 15, 2014 at 11:20:04AM +0100, Andrew Lunn wrote:
[..]
>  
> +/*
> + * Disable propagation of mbus errors to the CPU local bus, as this
> + * causes mbus errors (which can occur for example for PCI aborts) to
> + * throw CPU aborts, which we're not set up to deal with.
> + */
> +void kirkwood_disable_mbus_error_propagation(void)
> +{
> +	void __iomem *cpu_config;
> +
> +	cpu_config = ioremap(CPU_CONFIG_PHYS, 4);
> +	writel(readl(cpu_config) & ~CPU_CONFIG_ERROR_PROP, cpu_config);
> +}
> +

Any reason why this function above is not static __init?

And then: any reason why you're not unmapping the region?

(Sorry if this was already discussed)
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
