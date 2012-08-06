From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 6 Aug 2012 16:54:46 +0100
Subject: [PATCH 4/6] mfd: Use interrupt-parent as IRQ controller if
 specified in DT
In-Reply-To: <1344250002-6011-5-git-send-email-lee.jones@linaro.org>
References: <1344250002-6011-1-git-send-email-lee.jones@linaro.org>
 <1344250002-6011-5-git-send-email-lee.jones@linaro.org>
Message-ID: <20120806155446.GD29272@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2012 at 11:46:40AM +0100, Lee Jones wrote:

> -				domain = irq_find_host(parent->of_node);
> +#ifdef CONFIG_OF
> +				parent_node = of_irq_find_parent(np);
> +#endif

Shouldn't of_irq_find_parent() be stubbed out by the header?  Every
single user of this is going to need it.  Indeed, shouldn't we be making
irq_find_host() just do this?
