From: balbi@ti.com (Felipe Balbi)
Date: Tue, 23 Sep 2014 11:55:15 -0500
Subject: [PATCH v6 07/12] usb: chipidea: add a usb2 driver for ci13xxx
In-Reply-To: <5140494.LzvyOiyY3U@wuerfel>
References: <1411468088-5702-1-git-send-email-antoine.tenart@free-electrons.com>
 <2909480.SL9c0XWUbW@wuerfel> <20140923133645.GA18924@kwain>
 <5140494.LzvyOiyY3U@wuerfel>
Message-ID: <20140923165515.GA26604@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

On Tue, Sep 23, 2014 at 06:44:40PM +0200, Arnd Bergmann wrote:
> On Tuesday 23 September 2014 15:36:45 Antoine Tenart wrote:
> > On Tue, Sep 23, 2014 at 12:39:04PM +0200, Arnd Bergmann wrote:
> > > On Tuesday 23 September 2014 12:28:03 Antoine Tenart wrote:
> > > > +       if (dev->of_node) {
> > > > +               ret = ci_hdrc_usb2_dt_probe(dev, ci_pdata);
> > > > +               if (ret)
> > > > +                       goto clk_err;
> > > > +       } else {
> > > > +               ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> > > > +               if (ret)
> > > > +                       goto clk_err;
> > > > +       }
> > > > 
> > > 
> > > Why do you care about the non-DT case here? I think it would be nicer to
> > > open-code the ci_hdrc_usb2_dt_probe() function in here and remove
> > > the dma_set_mask_and_coherent(), which should not even be necessary for
> > > the case where you have a hardwired platform device.
> > > 
> > 
> > I thought we agreed to call dma_set_mask_and_coherent():
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/273335.html
> > 
> > I do not have a strong opinion on this as I only use the dt case for my
> > usage.
> 
> The question is more about who actually wants the non-DT case.
> 
> Since this is a new driver, I suspect that the answer is "nobody",
> as the existing board files are all for legacy platforms that we
> are not going to adapt for this driver.

wait a minute... will the legacy platforms be adapted to DT and, thus,
to this driver in the future ? I really don't want to keep several
copies of chipidea driver just because there are still some legacy
platforms still using them. I have said in the past and will say again,
everybody should move to the generic chipidea driver at the earliest
opportunity so we avoid duplication of work.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140923/c517e821/attachment.sig>
