From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 6 Aug 2012 16:37:52 +0100
Subject: [PATCH 1/1] Input: ab8500-ponkey: Make the distinction between
 DT and non-DT boots
In-Reply-To: <20120806081915.GA4518@core.coreip.homeip.net>
References: <1344256323-10484-1-git-send-email-lee.jones@linaro.org>
 <20120806081915.GA4518@core.coreip.homeip.net>
Message-ID: <20120806153750.GI10524@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2012 at 01:19:15AM -0700, Dmitry Torokhov wrote:
> > -	ponkey->irq_dbf = ab8500_irq_get_virq(ab8500, irq_dbf);
> > -	ponkey->irq_dbr = ab8500_irq_get_virq(ab8500, irq_dbr);
> > +
> > +	ponkey->irq_dbf = (np) ? ab8500_irq_get_virq(ab8500, irq_dbf) : irq_dbf;
> > +	ponkey->irq_dbr = (np) ? ab8500_irq_get_virq(ab8500, irq_dbr) : irq_dbr;
> 
> Why this isn't done inside ab8500_irq_get_virq()?

There's no reason why it can't be.

My first version of the patch did just that in fact.

Would that be your preference?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
