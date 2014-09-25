From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 25 Sep 2014 21:54:54 +0200
Subject: [PATCH v6 07/12] usb: chipidea: add a usb2 driver for ci13xxx
In-Reply-To: <201409252112.07513.arnd@arndb.de>
References: <1411468088-5702-1-git-send-email-antoine.tenart@free-electrons.com>
 <1411468088-5702-8-git-send-email-antoine.tenart@free-electrons.com>
 <201409252112.07513.arnd@arndb.de>
Message-ID: <20140925195454.GA6074@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On Thu, Sep 25, 2014 at 09:12:07PM +0200, Arnd Bergmann wrote:
> On Tuesday 23 September 2014, Antoine Tenart wrote:
> > +static int ci_hdrc_usb2_dt_probe(struct device *dev,
> > +                                struct ci_hdrc_platform_data *ci_pdata)
> > +{
> > +       ci_pdata->phy = of_phy_get(dev->of_node, 0);
> 
> FWIW, I accidentally built a kernel with this driver enabled and got a warning
> for this code. The problem is that ci_pdata->phy is a 'struct usb_phy' pointer,
> while of_phy_get() returns a generic 'struct phy'. While the two have similar
> behavior, they are not the same thing and this can't work.

That's because this series applies on top of:
https://lkml.org/lkml/2014/9/15/141

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
