From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 25 Sep 2014 12:20:20 +0200 (CEST)
Subject: [PATCH v2 01/22] PCI/MSI: Clean up struct msi_chip argument
In-Reply-To: <20140925071536.GG12423@ulmo>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-2-git-send-email-wangyijing@huawei.com>
 <20140925071536.GG12423@ulmo>
Message-ID: <alpine.DEB.2.10.1409251208420.4604@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Sep 2014, Thierry Reding wrote:

> On Thu, Sep 25, 2014 at 11:14:11AM +0800, Yijing Wang wrote:
> > Msi_chip functions setup_irq/teardown_irq rarely use msi_chip
> > argument.
> 
> That's not true. Out of the four drivers that you modify two use the
> parameter. And the two that don't probably should be using it too.
> 
> 50% is not "rarely". =)
> 
> >           We can look up msi_chip pointer by the device pointer
> > or irq number, so clean up msi_chip argument.
> 
> I don't like this particular change. The idea was to keep the API object
> oriented so that drivers wouldn't have to know where to get the MSI chip
> from. It also makes it more resilient against code reorganizations since
> the core code is the only place that needs to know where to get the chip
> from.

Right. We have the same thing in the irq_chip callbacks. All of them
take "struct irq_data", because it's already available in the core
code and it gives easy access to all information (chip, chipdata ...)
which is necessary for the callback implementations.

Thanks,

	tglx
