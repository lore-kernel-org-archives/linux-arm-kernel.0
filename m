From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 23 Sep 2014 15:36:45 +0200
Subject: [PATCH v6 07/12] usb: chipidea: add a usb2 driver for ci13xxx
In-Reply-To: <2909480.SL9c0XWUbW@wuerfel>
References: <1411468088-5702-1-git-send-email-antoine.tenart@free-electrons.com>
 <1411468088-5702-8-git-send-email-antoine.tenart@free-electrons.com>
 <2909480.SL9c0XWUbW@wuerfel>
Message-ID: <20140923133645.GA18924@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On Tue, Sep 23, 2014 at 12:39:04PM +0200, Arnd Bergmann wrote:
> On Tuesday 23 September 2014 12:28:03 Antoine Tenart wrote:
> > +       if (dev->of_node) {
> > +               ret = ci_hdrc_usb2_dt_probe(dev, ci_pdata);
> > +               if (ret)
> > +                       goto clk_err;
> > +       } else {
> > +               ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> > +               if (ret)
> > +                       goto clk_err;
> > +       }
> > 
> 
> Why do you care about the non-DT case here? I think it would be nicer to
> open-code the ci_hdrc_usb2_dt_probe() function in here and remove
> the dma_set_mask_and_coherent(), which should not even be necessary for
> the case where you have a hardwired platform device.
> 

I thought we agreed to call dma_set_mask_and_coherent():
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/273335.html

I do not have a strong opinion on this as I only use the dt case for my
usage.


Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
