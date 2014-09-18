From: srv_yingjoe.chen@mediatek.com (Joe.C)
Date: Thu, 18 Sep 2014 16:48:07 +0800
Subject: [RFC Part2 v1 01/21] irqdomain: Introduce new interfaces to
 support hierarchy irqdomains
In-Reply-To: <1410444228-3134-2-git-send-email-jiang.liu@linux.intel.com>
References: <1410444228-3134-1-git-send-email-jiang.liu@linux.intel.com>
 <1410444228-3134-2-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <1411030087.14746.2.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-09-11 at 22:03 +0800, Jiang Liu wrote:
> +#else	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
> +static inline int irq_domain_activate_irq(struct irq_data *data) { return 0; }
> +static inline int irq_domain_deactivate_irq(struct irq_data *data) { return 0; }
> +#endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
> +

I get the following build warnings on these lines:

../include/linux/irqdomain.h:75:47: warning: 'struct irq_data' declared
inside parameter list [enabled by default]
../include/linux/irqdomain.h:75:47: warning: its scope is only this
definition or declaration, which is probably not what you want [enabled
by default]
../include/linux/irqdomain.h:76:49: warning: 'struct irq_data' declared
inside parameter list [enabled by default

Joe.C
