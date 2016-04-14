From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 14 Apr 2016 16:26:51 +0200
Subject: [PATCH 2/2] pci: host: new driver for Marvell Armada 7K/8K PCIe
 controller
In-Reply-To: <3196859.0zi20qjiKR@wuerfel>
References: <1459071058-18328-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1459071058-18328-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <3196859.0zi20qjiKR@wuerfel>
Message-ID: <20160414162651.6765241a@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, 28 Mar 2016 23:21:57 +0200, Arnd Bergmann wrote:
> On Sunday 27 March 2016 11:30:58 Thomas Petazzoni wrote:
> > +       /* Wait until the link becomes active again */
> > +       while (timeout) {
> > +               if (armada8k_pcie_link_up(pp))
> > +                       break;
> > +               udelay(1);
> > +               timeout--;
> > +       }
> > 
> 
> Why the busy-loop here?
> 
> Maybe just do a single msleep(1) here to wait for the link to
> come up instead?

I've changed the udelay(1) by msleep(1). Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
