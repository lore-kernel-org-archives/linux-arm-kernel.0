From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 May 2010 09:17:23 +0100
Subject: [PATCH v3 2/2] ARM: S5PV210: Add Ext interrupt support
In-Reply-To: <1273749209-32461-1-git-send-email-kgene.kim@samsung.com>
References: <1273749209-32461-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100514081723.GC26822@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 13, 2010 at 08:13:29PM +0900, Kukjin Kim wrote:
> +static int s5p_irq_eint_set_type(unsigned int irq, unsigned int type)
> +{
> +	default:
> +		printk(KERN_ERR "No such irq type %d", type);
> +		return -1;

Is this really "Operation not permitted" aka -EPERM ?  Please change it
to a proper error code rather than being lazy.
