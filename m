From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 6 Aug 2012 18:21:10 +0100
Subject: [PATCH 4/6] mfd: Use interrupt-parent as IRQ controller if
 specified in DT
In-Reply-To: <20120806155446.GD29272@sirena.org.uk>
References: <1344250002-6011-1-git-send-email-lee.jones@linaro.org>
 <1344250002-6011-5-git-send-email-lee.jones@linaro.org>
 <20120806155446.GD29272@sirena.org.uk>
Message-ID: <20120806172109.GA31409@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2012 at 04:54:46PM +0100, Mark Brown wrote:
> On Mon, Aug 06, 2012 at 11:46:40AM +0100, Lee Jones wrote:
> 
> > -				domain = irq_find_host(parent->of_node);
> > +#ifdef CONFIG_OF
> > +				parent_node = of_irq_find_parent(np);
> > +#endif
> 
> Shouldn't of_irq_find_parent() be stubbed out by the header?  Every
> single user of this is going to need it.  Indeed, shouldn't we be making
> irq_find_host() just do this?

Sounds reasonable. I'll look into it tomorrow.
-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
