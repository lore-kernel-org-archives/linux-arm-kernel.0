From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Thu, 18 Sep 2014 16:58:19 +0800
Subject: [RFC Part2 v1 01/21] irqdomain: Introduce new interfaces to
 support hierarchy irqdomains
In-Reply-To: <1411030087.14746.2.camel@mtksdaap41>
References: <1410444228-3134-1-git-send-email-jiang.liu@linux.intel.com>	
 <1410444228-3134-2-git-send-email-jiang.liu@linux.intel.com>
 <1411030087.14746.2.camel@mtksdaap41>
Message-ID: <541A9EAB.3060000@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/9/18 16:48, Joe.C wrote:
> On Thu, 2014-09-11 at 22:03 +0800, Jiang Liu wrote:
>> +#else	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
>> +static inline int irq_domain_activate_irq(struct irq_data *data) { return 0; }
>> +static inline int irq_domain_deactivate_irq(struct irq_data *data) { return 0; }
>> +#endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
>> +
> 
> I get the following build warnings on these lines:
> 
> ../include/linux/irqdomain.h:75:47: warning: 'struct irq_data' declared
> inside parameter list [enabled by default]
> ../include/linux/irqdomain.h:75:47: warning: its scope is only this
> definition or declaration, which is probably not what you want [enabled
> by default]
> ../include/linux/irqdomain.h:76:49: warning: 'struct irq_data' declared
> inside parameter list [enabled by default
Hi Joe,
	Thanks for testing. We should add a forward declaration of
struct irq_data to the top of include/linux/irqdomain.h.
Will fix it in next version.
Regards!
Gerry
> 
> Joe.C
> 
> 
