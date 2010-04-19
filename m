From: daniel@caiaq.de (Daniel Mack)
Date: Mon, 19 Apr 2010 09:38:59 +0200
Subject: [PATCHv4 2.6.34-rc4 5/7] mxc: Add generic USB HW
	initialization for MX51
In-Reply-To: <20100419010340.GB15308@matterhorn.verdurent.com>
References: <1271445371-18501-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1271445371-18501-2-git-send-email-Dinh.Nguyen@freescale.com>
	<1271445371-18501-3-git-send-email-Dinh.Nguyen@freescale.com>
	<1271445371-18501-4-git-send-email-Dinh.Nguyen@freescale.com>
	<1271445371-18501-5-git-send-email-Dinh.Nguyen@freescale.com>
	<20100417170706.GY30801@buzzloop.caiaq.de>
	<20100419010340.GB15308@matterhorn.verdurent.com>
Message-ID: <20100419073859.GA30801@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 19, 2010 at 04:03:40AM +0300, Amit Kucheria wrote:
> On 10 Apr 17, Daniel Mack wrote:
> > > @@ -18,6 +19,7 @@
> > >  
> > >  #include <linux/platform_device.h>
> > >  #include <linux/io.h>
> > > +#include <linux/delay.h>
> > >  
> > >  #include <mach/hardware.h>
> > >  #include <mach/mxc_ehci.h>
> > > @@ -50,9 +52,14 @@
> > >  #define MX35_H1_TLL_BIT		(1 << 5)
> > >  #define MX35_H1_USBTE_BIT	(1 << 4)
> > >  
> > > -int mxc_set_usbcontrol(int port, unsigned int flags)
> > > +int mxc_intialize_usb_hw(int port, unsigned int flags)
> > 
> > This patch and the next one should be merged into one. The reason is
> > that you rename a function here and the next patch follows that change.
> > Especially when bisecting, this can lead to uncompilable checkouts of
> > the tree when stopping in the middle.
> 
> Also, patch 3 really belongs with this patch too since the #defines in
> patch 3 are used here.

Well, as long as the defines are commited _before_ their users, it
should be fine. But they can also be squashed into one, that's true.

Thanks,
Daniel
